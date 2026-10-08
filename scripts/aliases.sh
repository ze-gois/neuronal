# Source this file from Bash or Zsh:
# source /path/to/neuronal/scripts/aliases.sh
if [ -n "${BASH_VERSION:-}" ]; then
    _neuronal_alias_file="${BASH_SOURCE[0]}"
elif [ -n "${ZSH_VERSION:-}" ]; then
    _neuronal_alias_file="${(%):-%N}"
else
    printf '%s\n' 'neuronal aliases require Bash or Zsh.' >&2
    return 1
fi

_NEURONAL_ROOT="$(cd -- "$(dirname -- "$_neuronal_alias_file")/.." && pwd)"
unset _neuronal_alias_file

neuronal-cd() {
    cd -- "$_NEURONAL_ROOT"
}

neuronal-local-setup() {
    bash "$_NEURONAL_ROOT/scripts/jupyter.sh" local setup
}

neuronal-local() {
    bash "$_NEURONAL_ROOT/scripts/jupyter.sh" local lab
}

neuronal-pypi-setup() {
    bash "$_NEURONAL_ROOT/scripts/jupyter.sh" pypi setup
}

neuronal-pypi() {
    bash "$_NEURONAL_ROOT/scripts/jupyter.sh" pypi lab
}
