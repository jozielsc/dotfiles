git() {
  if [[ "$1" == "push" ]]; then
    command git "$@"
    local push_code=$?

    if [[ $push_code -eq 0 && -d ".github/workflows" ]]; then
      if command -v gh >/dev/null 2>&1; then
        echo ""
        echo -e "\033[1;34m[CI/CD]\033[0m Repositório com GitHub Actions detectado."
        
        # Pega o HASH exato do commit atual
        local current_sha=$(command git rev-parse HEAD 2>/dev/null)
        local run_id=""

        echo -e "\033[1;34m[CI/CD]\033[0m Aguardando o GitHub registrar a build do commit ${current_sha:0:7}..."

        # Tenta localizar a build do commit específico por até 15 segundos
        for i in {1..10}; do
          sleep 2
          run_id=$(gh run list --limit 10 --json databaseId,headSha -q ".[] | select(.headSha == \"$current_sha\") | .databaseId" 2>/dev/null | head -n 1)
          [[ -n "$run_id" ]] && break
        done

        if [[ -n "$run_id" ]]; then
          echo -e "\033[1;32m[CI/CD]\033[0m Workflow iniciado (ID: $run_id). Acompanhando em tempo real:\n"

          # 1. Acompanhamento AO VIVO no terminal (sem redirecionar para null)
          gh run watch "$run_id"

          # 2. Exibe o detalhamento completo dos passos ao finalizar
          echo ""
          echo -e "\033[1;36m[CI/CD] Detalhamento completo dos passos (Steps):\033[0m"
          echo ""

          local job_ids=($(gh run view "$run_id" --json jobs -q '.jobs[].id' 2>/dev/null))
          for job_id in "${job_ids[@]}"; do
            gh run view --job="$job_id"
            echo ""
          done
        else
          echo -e "\033[1;33m[CI/CD]\033[0m O GitHub Actions não iniciou um workflow para o commit ${current_sha:0:7}."
        fi
      fi
    fi

    return $push_code
  else
    command git "$@"
  fi
}
