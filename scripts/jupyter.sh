#!/usr/bin/env bash
# Usage: bash scripts/jupyter.sh [local|pypi] [setup|lab]
set -euo pipefail

project_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
mode="${1:-local}"
action="${2:-lab}"

case "$mode" in
  local)
    environment_path="$project_root/.venv"
    kernel_name="neuronal-local"
    kernel_label="Neuronal — Local"
    ;;
  pypi)
    environment_path="${NEURONAL_PYPI_ENV:-$HOME/venvs/neuronal-pypi}"
    kernel_name="neuronal-pypi"
    kernel_label="Neuronal — PyPI"
    ;;
  *)
    printf 'Usage: bash scripts/jupyter.sh [local|pypi] [setup|lab]\n' >&2
    exit 2
    ;;
esac

case "$action" in
  setup)
    if [[ ! -x "$environment_path/bin/python" ]]; then
      python3 -m venv "$environment_path"
    fi
    "$environment_path/bin/python" -m pip install -r "$project_root/examples/requirements.txt"
    if [[ "$mode" == local ]]; then
      (
        cd "$project_root"
        export VIRTUAL_ENV="$environment_path"
        export PATH="$environment_path/bin:$PATH"
        "$environment_path/bin/maturin" develop --locked
        "$environment_path/bin/python" -m pytest
      )
    else
      "$environment_path/bin/python" -m pip install neuronal-rs==0.1.0
    fi
    "$environment_path/bin/python" -m ipykernel install --user \
      --name "$kernel_name" --display-name "$kernel_label"
    printf 'Pronto. Abra com: bash scripts/jupyter.sh %s lab\n' "$mode"
    ;;
  lab)
    if [[ ! -x "$environment_path/bin/python" ]]; then
      printf 'Prepare primeiro: bash scripts/jupyter.sh %s setup\n' "$mode" >&2
      exit 1
    fi
    cd "$project_root"
    exec "$environment_path/bin/python" -m jupyterlab "$project_root/examples"
    ;;
  *)
    printf 'Action must be setup or lab.\n' >&2
    exit 2
    ;;
esac
