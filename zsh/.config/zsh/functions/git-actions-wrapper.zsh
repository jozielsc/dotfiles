git() {
  if [[ "$1" == "push" ]]; then
    # Executa o git push nativo
    command git "$@"
    local push_code=$?

    # Só executa a checagem se o push teve sucesso, se existe Actions e se o 'gh' está instalado
    if [[ $push_code -eq 0 && -d ".github/workflows" ]]; then
      if command -v gh >/dev/null 2>&1; then
        echo ""
        echo -e "\033[1;34m[CI/CD]\033[0m Repositório com GitHub Actions detectado."
        echo -e "\033[1;34m[CI/CD]\033[0m Aguardando o início do workflow no GitHub..."

        sleep 3

        local current_branch=$(command git rev-parse --abbrev-ref HEAD 2>/dev/null)
        local run_id=$(gh run list --branch "$current_branch" --limit 1 --json databaseId -q '.[0].databaseId' 2>/dev/null)

        if [[ -n "$run_id" ]]; then
          echo -e "\033[1;32m[CI/CD]\033[0m Acompanhando a build em tempo real (Ctrl+C para sair do log):\n"
          gh run watch "$run_id"
        fi
      fi
    fi

    return $push_code
  else
    command git "$@"
  fi
}
