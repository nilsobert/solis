import json
from flask import Flask, jsonify, request
from data import userData, globalData, saveGlobalData, saveUserData
from roof import charRoof
from flask_cors import CORS
import atexit
import copy

app = Flask(__name__)
CORS(app)


def saveData():
    saveUserData(uData=userData)
    saveGlobalData(gData=globalData)

atexit.register(saveData)

@app.route('/getRoof', methods=["POST"])
def getRoof():
    content = request.json
    lon = content["lon"]
    lat = content["lat"]
    data = charRoof(lon=lon, lat=lat)
    response = app.response_class(response=json.dumps({"area":str(data["area"]), "savings":str(data["save"])}),
    status=200,
    mimetype='application/json')
    return response

@app.route("/getFriendData", methods=["POST"])
def getFriendData():
    """Organize and send Friend data to Frontend"""
    content = request.json
    uid = content["uid"]
    user = userData[uid]
    friends_uid = user["friends"]
    
    data = {}
    for u in friends_uid:
        dat = userData[u]
        out = [[None, 0], [None, 0], [None, 0], [None, 0], [None, 0], [None, 0]]
        for n,a in enumerate(dat["monthly"]["heating"]):
            out[n][0] = a[0]
            out[n][1] += float(a[1])
        for n,a in enumerate(dat["monthly"]["electricity"]):
            out[n][0] = a[0]
            out[n][1] += float(a[1])
        for n,a in enumerate(dat["monthly"]["saved"]):
            out[n][0] = a[0]
            if out[n][1] != 0:
                out[n][1] = str(float(a[1])/out[n][1])
            else:
                out[n][1] = "0"
        data[dat["name"]] = out
    datSelf = userData[uid]
    outSelf = [[None, 0], [None, 0], [None, 0], [None, 0], [None, 0], [None, 0]]
    for n,a in enumerate(datSelf["monthly"]["heating"]):
        outSelf[n][0] = a[0]
        outSelf[n][1] += float(a[1])
    for n,a in enumerate(datSelf["monthly"]["electricity"]):
        outSelf[n][0] = a[0]
        outSelf[n][1] += float(a[1])
    for n,a in enumerate(datSelf["monthly"]["saved"]):
        outSelf[n][0] = a[0]
        if outSelf[n][1] != 0:
            outSelf[n][1] = str(float(a[1])/outSelf[n][1])
        else:
            outSelf[n][1] = "0"
    data["You"] = outSelf
    
    response = app.response_class(response=json.dumps(data),
    status=200,
    mimetype='application/json')
    return response

@app.route("/getGlobalData", methods=["POST"])
def getGlobalData():
    content = request.json
    uid = content["uid"]
    
    uids = userData.keys()
    out = [[None, []], [None, []], [None, []], [None, []], [None, []], [None, []]]
    l = len(uids)
    for u in uids:
        user = userData[u]["monthly"]
        for a in range(6):
            out[a][0] = user["saved"][a][0]
            div = (float(user["heating"][0][1])+float(user["electricity"][0][1]))
            if div != 0:
                out[a][1].append(float(user["saved"][0][1])/div)
            else:
                out[a][1].append(0)
    print(out)
    sort = [[None, []], [None, []], [None, []], [None, []], [None, []], [None, []]]
    for n,a in enumerate(out):
        sort[n][0] = a[0]
        sort[n][1] = sorted(a[1])
    top10, top30, top50 = [[None, 0], [None, 0], [None, 0], [None, 0], [None, 0], [None, 0]],[[None, 0], [None, 0], [None, 0], [None, 0], [None, 0], [None, 0]],[[None, 0], [None, 0], [None, 0], [None, 0], [None, 0], [None, 0]]
    print(sort)
    for n,a in enumerate(sort):
        top10[n][0] = top30[n][0] = top50[n][0] = a[0]
        top10[n][1] = str(sum(a[1][-round(0.1*l):])/round(0.1*l))
        top30[n][1] = str(sum(a[1][-round(0.3*l):])/round(0.3*l))
        top50[n][1] = str(sum(a[1][-round(0.5*l):])/round(0.5*l))
    data2 = {"Top 10":top10, "Top 30":top30, "Top 50":top50}
    print(data2)
    response = app.response_class(response=json.dumps(data2),
    status=200,
    mimetype='application/json')
    return response

@app.route("/getTopUserData", methods=["POST"])
def getTopUserData():
    content = request.json
    uid = content["uid"]
    user = userData[uid]
    print(user["monthly"]["saved"][-1][1], type(user["monthly"]["saved"][-1][1]))
    mothly_independence = float(user["monthly"]["saved"][-1][1])/(float(user["monthly"]["heating"][-1][1]) + float(user["monthly"]["electricity"][-1][1]))
    monthly_usage = float(user["monthly"]["heating"][-1][1]) + float(user["monthly"]["electricity"][-1][1])
    daily_usage = float(user["consumption_heating"][-1]) + float(user["consumption_electricity"][-1])
    monthly_usage = str(round(monthly_usage))
    mothly_independence = str(round(mothly_independence*100))
    daily_usage = str(round(daily_usage))
    data = {"monthly_independence": mothly_independence,"monthly_usage": monthly_usage, "daily_usage":daily_usage}
    response = app.response_class(response=json.dumps(data),
    status=200,
    mimetype='application/json')
    return response

@app.route("/getUserData", methods=["POST"])
def getUserData():
    content = request.json
    uid = content["uid"]
    user = userData[uid]
    data = user["monthly"]
    _data = copy.copy(data)
    for a in range(6):
        _data["saved"][a][1] = str(data["saved"][a][1])
        _data["heating"][a][1] = str(data["heating"][a][1])
        _data["electricity"][a][1] = str(data["electricity"][a][1])
    response = app.response_class(response=json.dumps(_data),
    status=200,
    mimetype='application/json')
    return response

@app.route("/heatPumpRecomendation", methods=["POST"])
def heatPumpRecomendation():
    content = request.json
    trans = {
        1:"Nice",
        2:"Acceptable",
        3:":|",
        4:"U serious?",
        12:"(O_O)",
        22:"(x_x)"
    }
    
    return ""

def heatPumpCalculation(key):
    
    with open("userData.json", "r") as f:
        j = json.load(f)
        j = dict(j)
        j = j.get(key)
        surplus = j.get("surplus")
        j = j.get("home")
        area = j.get("area")
        yearOfConstruction = j.get("yearOfConstruction")
        floorHeating = j.get("floor_heating")
        glass = j.get("glass")
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
    app.run(debug=True, port=8079, host="0.0.0.0")

    