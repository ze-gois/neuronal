"""Run the same panel as a standalone browser UI: python examples/panel.py."""
from nicegui import ui
from neuronal.panel import TimeAxisPanel

panel = TimeAxisPanel()

if __name__ == "__main__":
    ui.run(root=panel.build, host="127.0.0.1", reload=False,
           title="neuronal · time axis")
