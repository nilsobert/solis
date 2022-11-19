import requests
from PIL import Image
import numpy as np
import io
import math
import cv2

token = "sk.eyJ1Ijoibmlsc29iZXJ0IiwiYSI6ImNsYW45bGJsZDA2ZjczcG1qeDZjdjkweWkifQ.X5kTjVXsWXK8W9ThcprmTw"

def getAreaMult(lat, zoom):
    lat = abs(lat)
    if lat < 20:
        return (0.149*(20-lat) + 0.14*(lat))/20 if zoom == 19 else (0.299*(20-lat) + 0.281*(lat))/20
    if lat < 40:
        return (0.14*(40-lat) + 0.114*(abs(lat-20)))/20 if zoom == 19 else (0.281*(40-lat) + 0.229*(abs(lat-20)))/20
    if lat < 60:
        return (0.114*(60-lat) + 0.075*(abs(lat-40)))/20 if zoom == 19 else (0.229*(60-lat) + 0.149*(abs(lat-40)))/20
    if lat < 80:
        return (0.075*(80-lat) + 0.026*(abs(lat-60)))/20 if zoom == 19 else (0.149*(80-lat) + 0.052*(abs(lat-60)))/20
    return 0.026 if zoom == 19 else 0.052

def getImage(map_style, lon, lat, zoom, resolutionX, resolutionY):
    mapbox_url = f"https://api.mapbox.com/styles/v1/mapbox/{map_style}/static/{lon},{lat},{zoom}/{resolutionX}x{resolutionY}?access_token={token}"
    img = requests.get(mapbox_url)

    # store img as np array
    bytes_im = io.BytesIO(img.content)
    print(bytes_im)
    img = cv2.cvtColor(np.array(Image.open(bytes_im)), cv2.COLOR_RGB2BGR)
    return img


def charRoof(lon, lat):
    X, Y = 512,512
    zoom = 19
    def main():
        img = getImage("streets-v11", lon, lat, zoom, X, Y)
        tl = (X//2-5, Y//2+5)
        br = (X//2+5, Y//2-5)
        sq=[]
        for a in range(11):
            sq.append(sum(img[tl[0]+a][tl[1]])/3)
            sq.append(sum(img[tl[0]][tl[1]-a])/3)
            sq.append(sum(img[br[0]-a][br[1]])/3)
            sq.append(sum(img[br[0]][br[1]+a])/3)
        tone = int(max(set(sq), key = sq.count))
        tone = [tone]*3
        for ind,a in enumerate(img):
            for ind2, b in enumerate(a):
                if b[0] != tone[0]:
                    img[ind][ind2] = [0,0,0]
        #print(img)
        img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        objects = cv2.connectedComponentsWithStats(img)
        o = objects[1]
        sq=[]
        for a in range(11):
            sq.append(o[tl[0]+a][tl[1]])
            sq.append(o[tl[0]][tl[1]-a])
            sq.append(o[br[0]-a][br[1]])
            sq.append(o[br[0]][br[1]+a])
        num = int(max(set(sq), key = sq.count))
        flat = list(o.flatten())
        #fl = [0 if f != num else 255 for f in flat]
        #fl = np.array(fl)
        #fl = fl.reshape((512,512))
        #print(255 in fl.flatten())
        #fl = Image.fromarray(fl)
        #fl.show()
        pixels = flat.count(num)
        if __name__ == "__main__":
            cv2.imshow("",img)
            cv2.waitKey( )
            # closing all open windows
            cv2.destroyAllWindows()
        area = (getAreaMult(lat, zoom)**2)*pixels
        return area
    ar = main()
    if ar >200:
        zoom = 18
        ar = main()
    save = 0.302* math.cos(lat/180*math.pi)*0.50*ar
    return {"area": ar *0.95, "savings":save}
    
    #print(img)

if __name__ == "__main__":
    lon = 12.118771450982782
    lat = 48.55183459616669
    area = charRoof(lon, lat)  
    print(area)