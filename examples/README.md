# Pesquisa em examples

Notebooks são nosso espaço para hipóteses, protótipos, figuras e interpretação.
Algoritmos reutilizáveis passam para crates/neuronal-core; a interface fica em
crates/neuronal-python e as conveniências em python/neuronal.

- requirements.txt: ferramentas de pesquisa, sem escolher a origem do pacote.
- notebooks/01_hybrid_workflow.ipynb: primeira sessão guiada.
- time_axis.py: exemplo mínimo de terminal.
- results/: saídas locais ignoradas pelo Git; crie quando necessário.
- data/: dados locais ignorados pelo Git; documente a origem no notebook.

## Ambiente local (na raiz do repositório)

```bash
source .venv/bin/activate
python -m pip install -r examples/requirements.txt
maturin develop --locked
python -m ipykernel install --user --name neuronal-local --display-name "Neuronal — Local"
jupyter lab examples
```

## Ambiente PyPI (na raiz do repositório)

```bash
python -m venv ~/venvs/neuronal-pypi
source ~/venvs/neuronal-pypi/bin/activate
python -m pip install -r examples/requirements.txt
python -m pip install neuronal-rs==0.1.0
python -m ipykernel install --user --name neuronal-pypi --display-name "Neuronal — PyPI"
jupyter lab examples
```

Selecione o kernel correspondente. A versão publicada 0.1.0 contém time_axis;
sampled_span e neuronal.plotting são novos e ficam somente no ambiente local.

Mudança em Rust: maturin develop --locked no terminal local, depois reinicie
o kernel. Mudança Python: importlib.reload no módulo ou reinicie o kernel.
Não instale a versão PyPI por cima do ambiente local.

Salve notebooks versionados sem outputs (Edit → Clear Outputs of All Cells).
Para registrar um experimento, anote parâmetros, versão/commit, ambiente,
hipótese e conclusão. requirements.txt usa intervalos de versões; não é lockfile.
