#  /* ------------------------------ DATEJS ------------------------------ */
#  ===================================================================
#  Author: Matt Kruse <matt@mattkruse.com>
#  WWW: http:#www.mattkruse.com/
#
#  NOTICE: You may use this code for any purpose, commercial or
#  private, without any further permission from the author. You may
#  remove this notice from your final code if you wish, however it is
#  appreciated by the author if at least my web site address is kept.
#
#  You may *NOT* re-distribute this code in any way except through its
#  use. That means, you can include it in your product, or your web
#  site, or any other form where the code is actually being used. You
#  may not put the plain javascript up on your site for download or
#  include it in your javascript libraries for download. 
#  If you wish to share this code with others, please just point them
#  to the URL instead.
#  Please DO NOT link directly to my .js files from your site. Copy
#  the files to your server and use them there. Thank you.
#  ===================================================================
#  Modificado por Carlos Betancourt C. <carbetacar@gmail.com>
#  Web: betacar.net

String::isDate = (format = 'd/M/yyyy') ->
  date = this.getDateFromFormat(format)
  return false  if date is 0
  true

String::getDateFromFormat = (format = 'd/M/yyyy') ->
  val = this + ""
  format = format + ""
  i_val = 0
  i_format = 0
  c = ""
  token = ""
  token2 = ""
  x = undefined
  y = undefined
  now = new Date()
  year = now.getYear()
  month = now.getMonth() + 1
  date = 1
  hh = now.getHours()
  mm = now.getMinutes()
  ss = now.getSeconds()
  ampm = ""

  while i_format < format.length
    c = format.charAt(i_format)
    token = ""
    token += format.charAt(i_format++)  while (format.charAt(i_format) is c) and (i_format < format.length)
    if token is "yyyy" or token is "yy" or token is "y"
      if token is "yyyy"
        x = 4
        y = 4
      if token is "yy"
        x = 2
        y = 2
      if token is "y"
        x = 2
        y = 4
      year = _getInt(val, i_val, x, y)
      return 0  unless year?
      i_val += year.length
      if year.length is 2
        if year > 70
          year = 1900 + (year - 0)
        else
          year = 2000 + (year - 0)
    else if token is "MMM" or token is "NNN"
      month = 0
      i = 0

      while i < MONTH_NAMES.length
        month_name = MONTH_NAMES[i]
        if val.substring(i_val, i_val + month_name.length).toLowerCase() is month_name.toLowerCase()
          if token is "MMM" or (token is "NNN" and i > 11)
            month = i + 1
            month -= 12  if month > 12
            i_val += month_name.length
            break
        i++
      return 0  if (month < 1) or (month > 12)
    else if token is "EE" or token is "E"
      i = 0

      while i < DAY_NAMES.length
        day_name = DAY_NAMES[i]
        if val.substring(i_val, i_val + day_name.length).toLowerCase() is day_name.toLowerCase()
          i_val += day_name.length
          break
        i++
    else if token is "MM" or token is "M"
      month = _getInt(val, i_val, token.length, 2)
      return 0  if not month? or (month < 1) or (month > 12)
      i_val += month.length
    else if token is "dd" or token is "d"
      date = _getInt(val, i_val, token.length, 2)
      return 0  if not date? or (date < 1) or (date > 31)
      i_val += date.length
    else if token is "hh" or token is "h"
      hh = _getInt(val, i_val, token.length, 2)
      return 0  if not hh? or (hh < 1) or (hh > 12)
      i_val += hh.length
    else if token is "HH" or token is "H"
      hh = _getInt(val, i_val, token.length, 2)
      return 0  if not hh? or (hh < 0) or (hh > 23)
      i_val += hh.length
    else if token is "KK" or token is "K"
      hh = _getInt(val, i_val, token.length, 2)
      return 0  if not hh? or (hh < 0) or (hh > 11)
      i_val += hh.length
    else if token is "kk" or token is "k"
      hh = _getInt(val, i_val, token.length, 2)
      return 0  if not hh? or (hh < 1) or (hh > 24)
      i_val += hh.length
      hh--
    else if token is "mm" or token is "m"
      mm = _getInt(val, i_val, token.length, 2)
      return 0  if not mm? or (mm < 0) or (mm > 59)
      i_val += mm.length
    else if token is "ss" or token is "s"
      ss = _getInt(val, i_val, token.length, 2)
      return 0  if not ss? or (ss < 0) or (ss > 59)
      i_val += ss.length
    else if token is "a"
      if val.substring(i_val, i_val + 2).toLowerCase() is "am"
        ampm = "AM"
      else if val.substring(i_val, i_val + 2).toLowerCase() is "pm"
        ampm = "PM"
      else
        return 0
      i_val += 2
    else
      unless val.substring(i_val, i_val + token.length) is token
        return 0
      else
        i_val += token.length
  return 0  unless i_val is val.length
  
  if month is 2
    if (year % 4 is 0) and (year % 100 isnt 0) or (year % 400 is 0)
      return 0  if date > 29
    else
      return 0  if date > 28
  return 0  if date > 30  if (month is 4) or (month is 6) or (month is 9) or (month is 11)
  if hh < 12 and ampm is "PM"
    hh = hh - 0 + 12
  else hh -= 12  if hh > 11 and ampm is "AM"
  newdate = new Date(year, month - 1, date, hh, mm, ss)
  #newdate.getTime()

_getInt = (str, i, minlength, maxlength) ->
  while maxlength >= minlength
    token = str.substring(i, i + maxlength)
    return null  if token.length < minlength
    return token  if _isInteger(token)
    maxlength--
  null

_isInteger = (val) ->
  digits = "1234567890"
  i = 0

  while i < val.length
    return false  if digits.indexOf(val.charAt(i)) is -1
    i++
  true