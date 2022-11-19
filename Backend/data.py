import json

def saveUserData(uData):
    with open("userData.json", "w") as f:
        json.dump(uData,f)
def saveGlobalData(gData):
    with open("globalData.json", "w") as f:
        json.dump(gData,f)

userDataTemplate = {
    "uid": {
        "friends": "friends",
        "surplus": "surplus",
        "consumption_heating": "cons_heating",
        "consumption_electricity": "cons_electricity",
        "solar": {
            "installed":"solar",
            "save_solar": "save_solar"
            },
        "home":{
            "lat":"lat",
            "lon":"lon",
            "area": "area",
            "glass": "single/double/triple",
            "gas_heating": "T/F",
            "oil_heating": "T/F",
            "pellet_heating": "T/F",
            "pump_heating": "T/F",
            "floor_heating":"T/F",
            "pump_type": "None/air/air-water/earth/groundwater"
        }
    }
}

with open("userData.json", "r") as f:
    userData = dict(json.load(f))
with open("globalData.json", "r") as f:
    globalData = dict(json.load(f))

