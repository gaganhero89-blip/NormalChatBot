import asyncio
import importlib
import os
from threading import Thread
from flask import Flask

from pyrogram import idle
from NoxxNetwork import LOGGER, NoxxBot
from NoxxNetwork.modules import ALL_MODULES

# fake web server
app = Flask(__name__)

@app.route("/")
def home():
    return "Bot is running"

def run_server():
    app.run(host="0.0.0.0", port=8080)

async def bot_start():
    try:
        await NoxxBot.start()
    except Exception as ex:
        LOGGER.error(f"Failed to start bot: {ex}")
        return

    for module in ALL_MODULES:
        importlib.import_module("NoxxNetwork.modules." + module)

    LOGGER.info(f"@{NoxxBot.username} Started Successfully.")
    await idle()

if __name__ == "__main__":
    Thread(target=run_server, daemon=True).start()
    asyncio.run(bot_start())
