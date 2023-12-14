// import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormats_V1 {

  formattedDateTimeStyleOne(dateTimeFormation, context){
    return DateFormat("dd-MM-yyyy, hh:mma")
        .format(dateTimeFormation.dateTime);}

  formattedDateTimeStyleTwo(dateTimeFormation, context) {
    return DateFormat("dd-MM-yyyy, hh:mm:ssa")
        .format(dateTimeFormation.dateTime);}
  formattedDateTimeStyleThree(dateTimeFormation, context) {
    return DateFormat("dd/MM/yyyy (hh:mm:ssa)").format(DateTime.now());}

}

