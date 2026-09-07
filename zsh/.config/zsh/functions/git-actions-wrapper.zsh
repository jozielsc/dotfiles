git() {
  if [[ "$1" == "push" ]]; then
    command git "$@"
    local push_code=$?

    if [[ $push_code -eq 0 && -d ".github/workflows" ]]; then
      if command -v gh >/dev/null 2>&1; then
        echo ""
        echo -e "\033[1;34m[CI/CD]\033[0m Repositório com GitHub Actions detectado."
        echo -e "\033[1;34m[CI/CD]\033[0m Aguardando registro da execução no GitHub..."

        local current_branch=$(command git rev-parse --abbrev-ref HEAD 2>/dev/null)
        local run_id=""

        # Tenta obter o ID da nova build por até 10 segundos
        for i in {1..5}; do
          sleep 2
          run_id=$(gh run list --branch "$current_branch" --limit 1 --json databaseId -q '.[0].databaseId' 2>/dev/null)
          [[ -n "$run_id" ]] && break
        done

        if [[ -n "$run_id" ]]; then
          # Acompanha em tempo real se ainda estiver executando
          gh run watch "$run_id" >/dev/null 2>&1

          # Exibe o detalhamento de todos os passos (Jobs e Steps)
          echo ""
          echo -e "\033[1;36m[CI/CD] Detalhamento dos passos:\033[0m"
          gh run view "$run_id"

          # Se o workflow falhar, imprime o log do passo que deu erro automaticamente
          local conclusion=$(gh run view "$run_id" --json conclusion -q '.conclusion' 2>/dev/null)
          if [[ "$conclusion" == "failure" ]]; then
            echo ""
            echo -e "\033[1;31m[CI/CD] Logs da falha:\033[0m"
            gh run view "$run_id" --log-failed
          fi
        else
          echo -e "\033[1;33m[CI/CD]\033[0m Nenhuma execução iniciada para a branch '$current_branch'."
        fi
      fi
    fi

    return $push_code
  else
    command git "$@"
  fi
}
