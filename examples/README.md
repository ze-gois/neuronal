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

## Preparação por scripts

Os comandos acima também estão automatizados em [scripts/README.md](../scripts/README.md):

```bash
bash scripts/jupyter.sh local setup
bash scripts/jupyter.sh local lab
```

Para usar a versão publicada, substitua `local` por `pypi`.

## Painel NiceGUI (branch de desenvolvimento)

NiceGUI é uma dependência do pacote nesta branch. Prepare o ambiente local
com `bash scripts/jupyter.sh local setup`, inicie com
`bash scripts/jupyter.sh local lab` e abra `notebooks/02_nicegui_panel.ipynb`.
O pacote publicado 0.1.0 não contém esse painel.

`neuronal.panel.TimeAxisPanel` fornece controles, gráfico e estado compartilhado.
Use `await panel.show()` para embutir a interface na célula, `panel.parameters`
e `panel.result` para ler o experimento, e `panel.close()` para desativá-lo.
Cada instância tem uma URL própria; todos os clientes dessa instância compartilham
o mesmo estado. Feche a instância anterior antes de executar novamente a célula.

O servidor usa a event loop do kernel, sem threads nem `nest_asyncio`, e escuta
apenas em loopback numa porta livre. `await shutdown_panels()` encerra o servidor;
reinicie o kernel para iniciar uma nova sessão depois disso. Fechar o output ou
a aba do navegador não encerra o servidor. Jupyter remoto e HTTPS exigem uma
integração de proxy que este protótipo ainda não implementa.

Outra forma de execução: `python examples/panel.py`, no mesmo ambiente local.

### Validação desta implementação

Controles, callbacks, rejeição de parâmetros inválidos, fechamento e substituição
são cobertos por `tests/test_panel.py`, usando o simulador ASGI do NiceGUI.
O ambiente de implementação não disponibilizou Rust e bloqueou sockets: o teste
foi executado com a extensão Rust publicada 0.1.0 e o novo módulo Python.
O formato do notebook foi validado, mas a execução completa do iframe no
JupyterLab e do servidor Uvicorn ainda exige teste local nesta branch.
