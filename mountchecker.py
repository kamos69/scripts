# basic script for restarting Rclone mount on failure and notifying via pushbullet,
# hardcoded and not great but whatever, note this mounts read-only, change to suit your needs
# put this in your crontab to run every 5 minuntes
# */5 * * * * python /home/user/Rclonemountdown.py > /dev/null

from pushbullet import Pushbullet
import os
import subprocess
import logging
import time
import socket

logging.basicConfig(filename='mountcheck.log', level=logging.INFO, format='%(asctime)s %(levelname)s %(message)s')
logging.info('Rclone mount checker started')

DEVNULL = open(os.devnull, 'wb')

pb = Pushbullet('o.EqsPpLqhrdaSPw8yWRc7gcdQdCvm3lDt')

exists = os.path.exists("/home/kamos/media/tv")

host = socket.gethostname()

if exists is not True:
    logging.warning("Rclone mount is down")
    push = pb.push_note("Rclone mount down on "+host, "attempting restart")
    logging.info("attempting Rclone mount")
    subprocess.call(["bash", "/home/kamos/mount.sh"], stdin=None, stdout=DEVNULL)
    time.sleep(10.0)    # pause 10.0 seconds

    if os.path.exists("/home/kamos/media/tv") is not True:
        push = pb.push_note("Rclone mount still down on "+host, "Critical Error!!!")
        logging.warning("Rclone mount is still down", "Critical Error!!!")

    elif os.path.exists("/home/kamos/media/tv"):
           push = pb.push_note("Rclone mount back up on "+host, "restart successful")
           logging.info("Rclone mount restart succeeded")

else:
    logging.info('Rclone mount is up')
#    push = pb.push_note("Rclone mount checker on"+host, "Rclone mount is up")
#    print ('all good')
