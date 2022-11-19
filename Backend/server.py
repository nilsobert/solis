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

@app.route('/getRoof', methods=["POST"])
def getRoof():
    content = request.json()
    lon = content["lon"]
    lat = content["lat"]
    data = charRoof(lon=lon, lat=lat)
    return jsonify({"area":data["area"], "save":data["save"]})

@app.route("/getFriendData", methods=["POST"])
def getFriendData():
    content = request.json()
    uid = content["uid"]
    user = userData["uid"]
    friends_uid = user["friends"]
    
    return ""

@app.route("/getGlobalData", methods=["POST"])
def getGlobalData():
    return ""

@app.route("/getUserData", methods=["POST"])
def getUserData():
    content = request.json()
    uid = content["uid"]
    user = userData["uid"]
    data = user["monthly"]
    return jsonify(data)

def heatPumpCalculation(key):
    with open("userData.json", "r") as f:
        j = json.load(f)
        j = dict(j)
        j = j.get(key)
        surplus = j.get("surplus")
        print("JSON string = ", surplus, j)
        print()
        j = j.get("home")
        area = j.get("area")
        yearOfConstruction = j.get("yearOfConstruction")
        floorHeating = j.get("floor_heating")
        glass = j.get("glass")
        print("Construction year = ",yearOfConstruction," floorHeating = ",floorHeating," surplus = ",surplus," glass = ",glass,j)
        print()
        recommendation = 0
        if yearOfConstruction >= 1978:
            if floorHeating:
                if glass == "triple":
                    if surplus:
                        recommendation = 1
                    else:
                        recommendation = 2
                elif glass == "double":
                    if surplus:
                        recommendation = 2
                    else:
                        recommendation = 3
                else:
                    recommendation = 4
            else:
                if glass == "triple":
                    if surplus:
                        recommendation = 2
                    else:
                        recommendation = 3
                elif glass == "double":
                    if surplus:
                        recommendation = 3
                    else:
                        recommendation = 4
                else:
                    recommendation = 4
        else:
            recommendation = 4
    if recommendation==1:
        if area>130:
            recommendation =12
    if recommendation==2:
        if area > 130:
            recommendation = 22
    return recommendation

if __name__ == '__main__':
    ##print(f"User data:  {userData}")
    ##print(f"Global data:  {globalData}")
    ##print(heatPumpCalculation("hj4g56e07v94dkn8ctf5"))
    ##print(heatPumpCalculation("emyaqeix1h130r7xkp6z"))
    ##print(heatPumpCalculation("79uh2udkinyg60zcgtku"))
    ##print(heatPumpCalculation("9vqvesrg8gjv3tj9aeqs"))
    ##print(heatPumpCalculation("fj3g5zws13lt2ms6kllw"))
    app.run()

    