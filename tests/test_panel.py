"""Exercise callbacks through NiceGUI's socket-free user simulator."""
import asyncio

from nicegui.testing.user_simulation import user_simulation
from neuronal.panel import TimeAxisPanel


def test_panel_controls_and_replacement():
    async def scenario():
        async with user_simulation() as user:
            panel = TimeAxisPanel(samples=5, dt_ms=0.1)
            await user.open(panel.path)
            user.find('Samples').clear().type('10')
            user.find('dt (ms)').clear().type('0.5')
            user.find('Calculate').click()
            await asyncio.sleep(0.1)
            assert panel.parameters == {'samples': 10, 'dt_ms': 0.5}
            assert panel.result == [i * 0.5 for i in range(10)]
            user.find('dt (ms)').clear().type('0')
            user.find('Calculate').click()
            await asyncio.sleep(0.1)
            assert panel.parameters['dt_ms'] == 0.5
            panel.close()
            await asyncio.sleep(0.1)
            await user.should_see('Panel closed')
            replacement = TimeAxisPanel(samples=3, dt_ms=1)
            await user.open(replacement.path)
            await user.should_see('3 samples')
    asyncio.run(scenario())
