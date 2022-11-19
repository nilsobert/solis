import json
from flask import Flask, jsonify
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

@app.route('/getRoof', method=["POST"])
def getRoof():
    content = request.json()
    lon = content["lon"]
    lat = content["lat"]
    data = charRoof(lon=lon, lat=lat)
    return jsonify({"area":data["area"], "save":data["save"]})

@app.route("/getFriendData")
def getFriendData():
    content = request.json()
    uid = content["uid"]
    user = userData["uid"]
    friends_uid = user["friends"]
    
    return ""

@app.route("/getGlobalData")
def getGlobalData():
    return ""

@app.route("/getUserData")
def getUserData():
    return jsonify({
    "electricity": [["month1", 10], ["month2", 14], ["month3", 13], ["month4", 20], ["month5", 3], ["month6", 8]],
    "heating": [["month1", 3], ["month2", 11], ["month3", 63], ["month4", 4], ["month5", 1], ["month6", 12]],
    "saved": [["month1", 10], ["month2", 1], ["month3", 3], ["month4", 10], ["month5", 3], ["month6", 8]]
})

def heatPumpCalculation(key):
    with open("userData.json", "r") as f:
        j = json.load(f)
        j = dict(j)
        j = j.get(key)
        area = j.get("home").get("area")
        yearOfConstruction = j.get("home").get("yearOfConstruction")
        ##if (yearOfConstruction>=2010)
    print("JSON string = ",area,yearOfConstruction)
    print()
    return""

if __name__ == '__main__':
    print(f"User data:  {userData}")
    print(f"Global data:  {globalData}")
    heatPumpCalculation("1a2b3c4d5e6f70")
    app.run()

    