import argparse
import os
import time
from datetime import datetime
from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.firefox.service import Service
import pyautogui


# Uznem visa ekrana ekransavinu
def take_screenshot(url, folder, options, service):
    driver = webdriver.Firefox(options=options, service=service)
    # Atver saiti
    driver.get(url)
    # time.sleep, lai redzam, ka lapa ir paradijusies/ieladejusies
    time.sleep(3)
    # Maksimize logu
    driver.maximize_window()

    dt = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    filename = f"{folder}/{url.replace('https://', '').replace('/', '_')}_{dt}.png"

    # Autogui biblioteka, kas uznem ekransavinu no datora ekrana
    autogui_scrshot = pyautogui.screenshot()
    autogui_scrshot.save(filename)

    # Aizver driver
    driver.quit()
    print("Ekransavins saglabats ", folder, "/" , filename)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Saglabat majaslapas ekransavinu")
    parser.add_argument("url", type=str, help="Majaslapas pilns URL, no kuras uznemt ekransavinu")
    args = parser.parse_args()

    # Parbaudit vai ir screenshots direktorija, ja nav, tad izveidot
    folder = "screenshots"
    if not os.path.exists(folder):
        os.makedirs(folder)

    # Firefox options
    options = Options()
    options.set_preference("browser.safebrowsing.phishing.enabled", False)
    options.set_preference("browser.safebrowsing.malware.enabled", False)
    options.set_preference("browser.privatebrowsing.autostart", True)
    options.set_preference("browser.bookmarks.toolbar.visibility", "never")
    options.add_argument("--private")

    # Driver atrasanas vieta
    service = Service(executable_path=os.environ.get("GECKO_DRIVER", "/usr/local/bin/geckodriver"))
    service.start()

    # Uznemt ekransavinu
    take_screenshot(args.url, folder, options, service)
    service.stop()
