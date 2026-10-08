# Primeira publicação no PyPI

O nome desejado é neuronal. Um 404 na API pública não garante disponibilidade:
a confirmação ocorre quando o PyPI aceita o primeiro upload.

## Conta

Use sua conta em https://pypi.org/, verifique o email e configure 2FA.
Crie um API token para a primeira publicação com escopo da conta, pois o projeto
ainda não existe. Não coloque tokens no repositório nem em mensagens.
Depois, substitua-o por um token limitado a neuronal ou configure Trusted Publishing.

## Preparar e verificar

Na raiz do repositório, com o ambiente virtual ativado e a pasta dist vazia:

```bash
python -m pip install 'maturin>=1.9,<2' 'pytest>=8' 'twine>=6'
cargo fmt --all --check
cargo check --workspace --locked
maturin develop --locked
pytest
maturin build --release --locked --out dist
maturin sdist --out dist
python -m twine check dist/*
```

Teste o wheel em um ambiente virtual novo:

```bash
python -m venv /tmp/neuronal-wheel-check
/tmp/neuronal-wheel-check/bin/python -m pip install dist/*.whl
/tmp/neuronal-wheel-check/bin/python -c 'import neuronal; print(neuronal.time_axis(5, 0.1))'
```

Confira que o sdist inclui Cargo.toml da raiz, ambos os crates, arquivos Python
e README. O projeto usa licença MIT; confira a inclusão de LICENSE nos artefatos.

## Publicar

Depois de validar os artefatos:

```bash
python -m twine upload dist/*
```

No prompt de usuário, informe __token__. No prompt de senha, cole seu API token.
Não passe tokens como argumentos de linha de comando. O destino é o PyPI real.
O primeiro upload aceito cria o projeto. Arquivos publicados não podem ser
substituídos; correções exigem outra versão.

Verifique em um ambiente novo:

```bash
python -m venv /tmp/neuronal-pypi-check
/tmp/neuronal-pypi-check/bin/python -m pip install neuronal==0.1.0
/tmp/neuronal-pypi-check/bin/python -c 'import neuronal; print(neuronal.__version__)'
```

O wheel local atende somente sua plataforma. O sdist permite compilar em outras
plataformas, mas exige Rust e ferramentas de compilação. Wheels portáteis para
Linux, Windows e macOS serão uma entrega posterior.
