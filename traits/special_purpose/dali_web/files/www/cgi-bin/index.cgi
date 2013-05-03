#!/bin/bash

echo "Content-type: text/html"
echo ""
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Form Example</title>'
echo '</head>'
echo '<body>'

  echo "<form method=GET action=\"${SCRIPT}\">"\
       '<table nowrap>'\
          '<tr><td>Address</TD><TD><input type="text" name="address" size=12></td></tr>'\
          '<tr><td>Command</td><td><input type="text" name="command" size=12 value=""></td>'\
          '<tr><td>Parameter</td><td><input type="text" name="param" size=12 value=""></td>'\
          '</tr></table>'

  echo '<input type="radio" name="address_mode" value="device" checked>Device<br>'\
       '<input type="radio" name="address_mode" value="group">Group<br>'\
       '<input type="radio" name="address_mode" value="broadcast">Broadcast<br>'

  echo '<br><input type="submit" value="Process Form">'\
       '<input type="reset" value="Reset"></form>'

  # Make sure we have been invoked properly.

  if [ "$REQUEST_METHOD" != "GET" ]; then
        echo "<hr>Script Error:"\
             "<br>Usage error, cannot complete request, REQUEST_METHOD!=GET."\
             "<br>Check your FORM declaration and be sure to use METHOD=\"GET\".<hr>"
        exit 1
  fi

  # If no search arguments, exit gracefully now.

  if [ -z "$QUERY_STRING" ]; then
        exit 0
  else
     # No looping this time, just extract the data you are looking for with sed:
     ADDRESS=`echo "$QUERY_STRING" | sed -n 's/^.*address=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     COMMAND=`echo "$QUERY_STRING" | sed -n 's/^.*command=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     PARAM=`echo "$QUERY_STRING" | sed -n 's/^.*param=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     ADDRESS_MODE=`echo "$QUERY_STRING" | sed -n 's/^.*address_mode=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
     echo "address: " $ADDRESS
     echo '<br>'
     echo "command: " $COMMAND
     echo '<br>'
     echo "paraemeter: " $PARAM
     echo '<br>'
     echo "address_mode: " $ADDRESS_MODE
     echo '<br>'
     echo $COMMAND " " $ADDRESS " " $PARAM | daliwrite
  fi
echo '</body>'
echo '</html>'

exit 0
