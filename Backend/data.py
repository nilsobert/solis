import json

def saveUserData(uData):
    with open("userData.json", "w") as f:
        json.dump(uData,f)
def saveGlobalData(gData):
    with open("globalData.json", "w") as f:
        json.dump(gData,f)

userDataTemplate = {
    "uid":{
        "friends": [],
        "energyConsumption": 0,
        "energySavings": 0,
        "home":{
            "area": 0,
            "solar": False,
            "heatpump": {
                "air": False,
                "airWater": False,
                "earth": False,
                "ground": False
            },
            "gas": False,
            "oil": False,
            "pellets": False,
            "floorHeating": False,
        }
    }
}

with open("userData.json", "r") as f:
    userData = dict(json.load(f))
with open("globalData.json", "r") as f:
    globalData = dict(json.load(f))

