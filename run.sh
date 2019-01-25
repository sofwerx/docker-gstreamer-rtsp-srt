#!/bin/bash
if [ -n "${RTSP_USER_ID}" ]; then
  RTSP_USER_ID="user-id=${RTSP_USER_ID}"
fi
if [ -n "${RTSP_USER_PW}" ]; then
  RTSP_USER_PW="user-pw=${RTSP_USER_PW}"
fi
if [ -n "${SRT_PASSPHRASE}" ]; then
  SRT_PASSPHRASE="passphrase=${SRT_PASSPHRASE}"
  SRT_KEY_LENGTH="key-length=${SRT_KEY_LENGTH:-32}"
fi

exec gst-launch-1.0 -v rtspsrc ${RTSP_USER_ID} ${RTSP_USER_PW} location=${RTSP_URL} latency=0 ! rtph264depay ! h264parse ! mpegtsmux alignment=7 ! rndbuffersize max=1316 min=1316 ! srtserversink uri=srt://:${SRT_PORT}/ latency=0 ${SRT_PASSPHRASE} ${SRT_KEY_LENGTH}
