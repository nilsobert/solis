import json

from flask import Flask, render_template
from data import userData, globalData, saveGlobalData, saveUserData
from roof import charRoof
import atexit

app = Flask(__name__)


"""
/getRoof        get roof data
/getFriendData  get Friends energy data
/getGlobalData  get global energy data
/updateUserData update personal data
"""

def saveData():
    saveUserData(uData=userData)
    saveGlobalData(gData=globalData)

atexit.register(saveData)

app.debug = True

@app.route('/getRoof')
def getRoof():
    return ""

@app.route("/getFriendData")
def getFriendData():
    return ""

@app.route("/getGlobalData")
def getGlobalData():
    return ""

@app.route("/updateUserData")
def updateUserData():
    return ""

def heatPumpCalculation(key):
    with open("userData.json", "r") as f:
        j = json.load(f)
        j = dict(j)
        j = j.get(key)
        area = j.get("home").get("area")
        yearOfConstruction = j.get("home").get("yearOfConstruction")
        if yearOfConstruction >= 1978:

            return "A heatpump is definetly a good idea!"
    print("JSON string = ",area,yearOfConstruction)
    print()
    return""

if __name__ == '__main__':
    print(f"User data:  {userData}")
    print(f"Global data:  {globalData}")
    heatPumpCalculation("1a2b3c4d5e6f70")
    app.run()

    