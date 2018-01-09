# basic script for restarting acd mount on failure and notifying via pushbullet, 
# hardcoded and not great but whatever, note this mounts read-only, change to suit your needs
# put this in your crontab to run every 5 minuntes
# */5 * * * * python /home/user/acdmountdown.py > /dev/null

from pushbullet import Pushbullet
import os
import subprocess
import logging
import time

logging.basicConfig(filename='logs/acdrclonemount.log', level=logging.INFO, format='%(asctime)s %(levelname)s %(message)s')
logging.info('ACD mount checker started')

DEVNULL = open(os.devnull, 'wb')

pb = Pushbullet('o.EqsPpLqhrdaSPw8yWRc7gcdQdCvm3lDt')

exists = os.path.exists("/home/kamos/media/tv")

if exists is not True:
    logging.warning("ACD mount is down")
    push = pb.push_note("ACD mount down", "attempting restart")
#    logging.info("attempting ACD mount")
#    subprocess.call(["bash", "/home/kamos/crons/rclonemount.sh"], stdin=None, stdout=DEVNULL)
    time.sleep(10.0)    # pause 10.0 seconds

    if os.path.exists("/home/kamos/media/tv") is not True:
        push = pb.push_note("ACD mount still down", "Critical Error!!!")
        logging.warning("ACD mount is still down", "Critical Error!!!")

    elif os.path.exists("/home/kamos/media/tv"):
           push = pb.push_note("ACD mount back up", "restart successful")
           logging.info("ACD mount restart succeeded")

else:
    logging.info('ACD mount is up')
#    push = pb.push_note("ACD mount checker", "ACD mount is up")
#    print ('all good')
