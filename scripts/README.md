# Scripts de desenvolvimento

Execute a partir da raiz do repositório.

## Local

```bash
bash scripts/jupyter.sh local setup
bash scripts/jupyter.sh local lab
```

Setup instala as dependências, compila com maturin, executa pytest e registra
o kernel Neuronal — Local. Reusa .venv ou cria se necessário.
Requer Rust/Cargo disponíveis no PATH.

## PyPI

```bash
bash scripts/jupyter.sh pypi setup
bash scripts/jupyter.sh pypi lab
```

Usa ~/venvs/neuronal-pypi e registra Neuronal — PyPI com a versão publicada
0.1.0. NEURONAL_PYPI_ENV permite definir outro caminho absoluto.

Setup é explícito; lab apenas abre JupyterLab. Selecione o kernel adequado
no notebook. Depois de mudar Rust, repita local setup e reinicie o kernel.

Notebooks e experimentos ficam em examples/.
