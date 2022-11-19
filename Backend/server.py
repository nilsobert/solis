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


if __name__ == '__main__':
    print(f"User data:  {userData}")
    print(f"Global data:  {globalData}")
    app.run()
    
    