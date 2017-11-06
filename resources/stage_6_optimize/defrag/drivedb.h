/*
 * drivedb.h - smartmontools drive database file
 *
 * Home page of code is: http://www.smartmontools.org
 *
 * Copyright (C) 2003-11 Philip Williams, Bruce Allen
 * Copyright (C) 2008-17 Christian Franke
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * You should have received a copy of the GNU General Public License
 * (for example COPYING); If not, see <http://www.gnu.org/licenses/>.
 *
 */

/*
 * Structure used to store drive database entries:
 *
 * struct drive_settings {
 *   const char * modelfamily;
 *   const char * modelregexp;
 *   const char * firmwareregexp;
 *   const char * warningmsg;
 *   const char * presets;
 * };
 *
 * The elements are used in the following ways:
 *
 *  modelfamily     Informal string about the model family/series of a
 *                  device. Set to "" if no info (apart from device id)
 *                  known.  The entry is ignored if this string starts with
 *                  a dollar sign.  Must not start with "USB:", see below.
 *  modelregexp     POSIX extended regular expression to match the model of
 *                  a device.  This should never be "".
 *  firmwareregexp  POSIX extended regular expression to match a devices's
 *                  firmware.  This is optional and should be "" if it is not
 *                  to be used.  If it is nonempty then it will be used to
 *                  narrow the set of devices matched by modelregexp.
 *  warningmsg      A message that may be displayed for matching drives.  For
 *                  example, to inform the user that they may need to apply a
 *                  firmware patch.
 *  presets         String with vendor-specific attribute ('-v') and firmware
 *                  bug fix ('-F') options.  Same syntax as in smartctl command
 *                  line.  The user's own settings override these.
 *
 * The regular expressions for drive model and firmware must match the full
 * string.  The effect of "^FULLSTRING$" is identical to "FULLSTRING".
 * The form ".*SUBSTRING.*" can be used if substring match is desired.
 *
 * The table will be searched from the start to end or until the first match,
 * so the order in the table is important for distinct entries that could match
 * the same drive.
 *
 *
 * Format for USB ID entries:
 *
 *  modelfamily     String with format "USB: DEVICE; BRIDGE" where
 *                  DEVICE is the name of the device and BRIDGE is
 *                  the name of the USB bridge.  Both may be empty
 *                  if no info known.
 *  modelregexp     POSIX extended regular expression to match the USB
 *                  vendor:product ID in hex notation ("0x1234:0xabcd").
 *                  This should never be "".
 *  firmwareregexp  POSIX extended regular expression to match the USB
 *                  bcdDevice info.  Only compared during search if other
 *                  entries with same USB vendor:product ID exist.
 *  warningmsg      Not used yet.
 *  presets         String with one device type ('-d') option.
 *
 */

/*
const drive_settings builtin_knowndrives[] = {
 */
  { "$Id: drivedb.h 4591 2017-11-04 22:40:53Z chrfranke $",
    "-", "-",
    "This is a dummy entry to hold the SVN-Id of drivedb.h",
    ""
  },
  { "DEFAULT",
    "-", "-",
    "Default settings",
    "-v 1,raw48,Raw_Read_Error_Rate "
    "-v 2,raw48,Throughput_Performance "
    "-v 3,raw16(avg16),Spin_Up_Time "
    "-v 4,raw48,Start_Stop_Count "
    "-v 5,raw16(raw16),Reallocated_Sector_Ct "
    "-v 6,raw48,Read_Channel_Margin,HDD "
    "-v 7,raw48,Seek_Error_Rate,HDD "
    "-v 8,raw48,Seek_Time_Performance,HDD "
    "-v 9,raw24(raw8),Power_On_Hours "
    "-v 10,raw48,Spin_Retry_Count,HDD "
    "-v 11,raw48,Calibration_Retry_Count,HDD "
    "-v 12,raw48,Power_Cycle_Count "
    "-v 13,raw48,Read_Soft_Error_Rate "
    //  14-174 Unknown_Attribute
    "-v 175,raw48,Program_Fail_Count_Chip,SSD "
    "-v 176,raw48,Erase_Fail_Count_Chip,SSD "
    "-v 177,raw48,Wear_Leveling_Count,SSD "
    "-v 178,raw48,Used_Rsvd_Blk_Cnt_Chip,SSD "
    "-v 179,raw48,Used_Rsvd_Blk_Cnt_Tot,SSD "
    "-v 180,raw48,Unused_Rsvd_Blk_Cnt_Tot,SSD "
    "-v 181,raw48,Program_Fail_Cnt_Total "
    "-v 182,raw48,Erase_Fail_Count_Total,SSD "
    "-v 183,raw48,Runtime_Bad_Block "
    "-v 184,raw48,End-to-End_Error "
    //  185-186 Unknown_Attribute
    "-v 187,raw48,Reported_Uncorrect "
    "-v 188,raw48,Command_Timeout "
    "-v 189,raw48,High_Fly_Writes,HDD "
    "-v 190,tempminmax,Airflow_Temperature_Cel "
    "-v 191,raw48,G-Sense_Error_Rate,HDD "
    "-v 192,raw48,Power-Off_Retract_Count "
    "-v 193,raw48,Load_Cycle_Count,HDD "
    "-v 194,tempminmax,Temperature_Celsius "
    "-v 195,raw48,Hardware_ECC_Recovered "
    "-v 196,raw16(raw16),Reallocated_Event_Count "
    "-v 197,raw48,Current_Pending_Sector "
    "-v 198,raw48,Offline_Uncorrectable "
    "-v 199,raw48,UDMA_CRC_Error_Count "
    "-v 200,raw48,Multi_Zone_Error_Rate,HDD "
    "-v 201,raw48,Soft_Read_Error_Rate,HDD "
    "-v 202,raw48,Data_Address_Mark_Errs,HDD "
    "-v 203,raw48,Run_Out_Cancel "
    "-v 204,raw48,Soft_ECC_Correction "
    "-v 205,raw48,Thermal_Asperity_Rate "
    "-v 206,raw48,Flying_Height,HDD "
    "-v 207,raw48,Spin_High_Current,HDD "
    "-v 208,raw48,Spin_Buzz,HDD "
    "-v 209,raw48,Offline_Seek_Performnce,HDD "
    //  210-219 Unknown_Attribute
    "-v 220,raw48,Disk_Shift,HDD "
    "-v 221,raw48,G-Sense_Error_Rate,HDD "
    "-v 222,raw48,Loaded_Hours,HDD "
    "-v 223,raw48,Load_Retry_Count,HDD "
    "-v 224,raw48,Load_Friction,HDD "
    "-v 225,raw48,Load_Cycle_Count,HDD "
    "-v 226,raw48,Load-in_Time,HDD "
    "-v 227,raw48,Torq-amp_Count,HDD "
    "-v 228,raw48,Power-off_Retract_Count "
    //  229 Unknown_Attribute
    "-v 230,raw48,Head_Amplitude,HDD "
    "-v 231,raw48,Temperature_Celsius "
    "-v 232,raw48,Available_Reservd_Space "
    "-v 233,raw48,Media_Wearout_Indicator,SSD "
    //  234-239 Unknown_Attribute
    "-v 240,raw24(raw8),Head_Flying_Hours,HDD "
    "-v 241,raw48,Total_LBAs_Written "
    "-v 242,raw48,Total_LBAs_Read "
    //  243-249 Unknown_Attribute
    "-v 250,raw48,Read_Error_Retry_Rate "
    //  251-253 Unknown_Attribute
    "-v 254,raw48,Free_Fall_Sensor,HDD"
  },
  { "Apacer SSD",
    "(2|4|8|16|32)GB SATA Flash Drive", // tested with APSDM002G15AN-CT/SFDDA01C and SFI2101D, APSDM004G13AN-AT/SFDE001A
    "SF(DDA01C|I2101D|DE001A)", "", // spec found at http://wfcache.advantech.com/www/certified-peripherals/documents/96fmcff-04g-cs-ap_Datasheet.pdf
    "-v 160,raw48,Initial_Bad_Block_Count "
    "-v 161,raw48,Bad_Block_Count "
    "-v 162,raw48,Spare_Block_Count "
    "-v 163,raw48,Max_Erase_Count "
    "-v 164,raw48,Average_Erase_Count "
    "-v 165,raw48,Average_Erase_Count " // could be wrong
    "-v 166,raw48,Later_Bad_Block_Count "
    "-v 167,raw48,SSD_Protect_Mode "
    "-v 168,raw48,SATA_PHY_Err_Ct "
  },
  { "Apple MacBook Air SSD", // probably Toshiba
    "APPLE SSD TS(064|128)E", // tested with APPLE SSD TS064E/TQAABBF0
    "", "",
    "-v 173,raw48,Wear_Leveling_Count " //  ]
    "-v 241,raw48,Host_Writes_GiB "     //  ]  guessed (ticket #655)
    "-v 242,raw48,Host_Reades_GiB "     //  ]
  },
  { "Apple SD/SM/TS...E/F/G SSDs", // SanDisk/Samsung/Toshiba?
    "APPLE SSD (S[DM]|TS)0?(128|256|512|768|1024)[EFG]", // tested with APPLE SSD SD256E/1021AP, SD0128F/A223321
     // APPLE SSD SM768E/CXM90A1Q, SM0512F/UXM2JA1Q, TS0256F/109L0704, SM0512G/BXW1SA0Q, SM1024G/BXW1SA0Q
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 169,raw48,Unknown_Apple_Attrib "
    "-v 173,raw48,Wear_Leveling_Count " // ]
    "-v 174,raw48,Host_Reads_MiB "      // ] guessed (ticket #342), S[DM]*F only
    "-v 175,raw48,Host_Writes_MiB "     // ]
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 197,raw48,Current_Pending_Sector "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
  //"-v 240,raw48,Unknown_SSD_Attribute "
  },
  { "Crucial/Micron RealSSD C300/P300", // Marvell 88SS9174
    "C300-CTFDDA[AC](064|128|256)MAG|" // tested with C300-CTFDDAC128MAG/0002,
      // C300-CTFDDAC064MAG/0006
    "P300-MTFDDAC(050|100|200)SAL", // tested with P300-MTFDDAC100SAL/0003
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Grown_Failing_Block_Ct "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Wear_Leveling_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 181,raw16,Non4k_Aligned_Access "
    "-v 183,raw48,SATA_Iface_Downshift "
  //"-v 184,raw48,End-to-End_Error "
  //"-v 187,raw48,Reported_Uncorrect "
  //"-v 188,raw48,Command_Timeout "
    "-v 189,raw48,Factory_Bad_Block_Ct "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 195,raw48,Hardware_ECC_Recovered "
  //"-v 196,raw16(raw16),Reallocated_Event_Count "
  //"-v 197,raw48,Current_Pending_Sector "
  //"-v 198,raw48,Offline_Uncorrectable "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
    "-v 202,raw48,Percent_Lifetime_Used "
    "-v 206,raw48,Write_Error_Rate "
  },
  { "Crucial/Micron RealSSD m4/C400/P400", // Marvell 9176, fixed firmware
    "C400-MTFDDA[ACK](064|128|256|512)MAM|"
    // M4-CT032M4SSD3/04MH
    "M4-CT(032|064|128|256|512)M4SSD[123]|" // tested with M4-CT512M4SSD2/0309
    "MTFDDA[AK](064|128|256|512|050|100|200|400)MA[MNR]-1[JKS]1.*", // tested with
       // MTFDDAK256MAR-1K1AA/MA52, MTFDDAK256MAM-1K12/08TH,
       // MTFDDAA064MAR-1J1AB  49Y5835 49Y5838IBM/MA49 (P400e)
    "030[9-Z]|03[1-Z].|0[4-Z]..|[1-Z]....*", // >= "0309"
    "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Grown_Failing_Block_Ct "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Wear_Leveling_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 181,raw16,Non4k_Aligned_Access "
    "-v 183,raw48,SATA_Iface_Downshift "
  //"-v 184,raw48,End-to-End_Error "
  //"-v 187,raw48,Reported_Uncorrect "
  //"-v 188,raw48,Command_Timeout "
    "-v 189,raw48,Factory_Bad_Block_Ct "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 195,raw48,Hardware_ECC_Recovered "
  //"-v 196,raw16(raw16),Reallocated_Event_Count "
  //"-v 197,raw48,Current_Pending_Sector "
  //"-v 198,raw48,Offline_Uncorrectable "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
    "-v 202,raw48,Perc_Rated_Life_Used "
    "-v 206,raw48,Write_Error_Rate "
    "-v 225,raw48,Unknown_Marvell_Attr " // P400e
    "-v 231,raw48,Unknown_Marvell_Attr " // P400e
    "-v 242,raw48,Host_Reads" // P400e: 2MiB?
  },
  { "Crucial/Micron RealSSD m4/C400", // Marvell 9176, buggy or unknown firmware
    "C400-MTFDDA[ACK](064|128|256|512)MAM|" // tested with C400-MTFDDAC256MAM/0002
    "M4-CT(032|064|128|256|512)M4SSD[123]", // tested with M4-CT064M4SSD2/0002,
      // M4-CT064M4SSD2/0009, M4-CT256M4SSD3/000F
    "",
    "This drive may hang after 5184 hours of power-on time:\n"
    "http://www.tomshardware.com/news/Crucial-m4-Firmware-BSOD,14544.html\n"
    "See the following web pages for firmware updates:\n"
    "http://www.crucial.com/support/firmware.aspx\n"
    "http://www.micron.com/products/solid-state-storage/client-ssd#software",
    "-v 170,raw48,Grown_Failing_Block_Ct "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Wear_Leveling_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 181,raw16,Non4k_Aligned_Access "
    "-v 183,raw48,SATA_Iface_Downshift "
    "-v 189,raw48,Factory_Bad_Block_Ct "
    "-v 202,raw48,Perc_Rated_Life_Used "
    "-v 206,raw48,Write_Error_Rate"
  },
  { "Crucial/Micron MX1/2/300, M5/600, 1100 Client SSDs",
    "Crucial_CT(128|256|512)MX100SSD1|"// Marvell 88SS9189, tested with Crucial_CT256MX100SSD1/MU01
    "Crucial_CT(200|250|256|500|512|1000|1024)MX200SSD[1346]|" // Marvell 88SS9189, tested with
      // Crucial_CT500MX200SSD1/MU01, Crucial_CT1024MX200SSD1/MU01, Crucial_CT250MX200SSD3/MU01,
      // Crucial_CT250MX200SSD1/MU03
    "Crucial_CT(275|525|1050|2050)MX300SSD[14]|" // Marvell 88SS1074, tested with
      // Crucial_CT525MX300SSD1/M0CR021, Crucial_CT2050MX300SSD1/M0CR031, Crucial_CT275MX300SSD1/M0CR040
    "Crucial_CT(120|240|480|960)M500SSD[134]|" // Marvell 88SS9187, tested with
      // Crucial_CT120M500SSD1/MU02, Crucial_CT120M500SSD3/MU02, Crucial_CT240M500SSD1/MU03,
      // Crucial_CT480M500SSD1/MU03, Crucial_CT960M500SSD1/MU03, Crucial_CT240M500SSD4/MU05
    "Crucial_CT(128|256|512|1024)M550SSD[134]|" // tested with Crucial_CT512M550SSD3/MU01,
      // Crucial_CT1024M550SSD1/MU01, Crucial_CT128M550SSD4/MU02
    "Micron_M500_MTFDDA[KTV](120|240|480|960)MAV|"// tested with Micron_M500_MTFDDAK960MAV/MU05
    "(Micron_)?M510[_-]MTFDDA[KTV](128|256)MAZ|" // tested with M510-MTFDDAK256MAZ/MU01
    "(Micron_)?M550[_-]MTFDDA[KTV](064|128|256|512|1T0)MAY|" // tested with M550-MTFDDAK256MAY/MU01
    "Micron_M600_(EE|MT)FDDA[KTV](128|256|512|1T0)MBF[25Z]?|" // tested with Micron_M600_MTFDDAK1T0MBF/MU01
    "Micron_M500DC_(EE|MT)FDDA[AK](120|240|480|800)MBB|" // tested with Micron_M500DC_EEFDDAA120MBB/129, Micron_M500DC_MTFDDAK800MBB/0129
    "Micron_1100_MTFDDA[KV](256|512|1T0|2T0)TBN|" // Marvell 88SS1074, tested Micron_1100_MTFDDAK256TBN/M0MU020
    "MICRON_M510DC_(EE|MT)FDDAK(120|240|480|800|960)MBP|" // Micron_M510DC_MTFDDAK240MBP/0005
    "Micron_5100_(EE|MT)FDDA[KV](240|480|960|1T9|3T8|7T6)T(BY|CB|CC)", // tested with Micron_5100_MTFDDAK1T9TBY
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
    "-v 5,raw48,Reallocate_NAND_Blk_Cnt "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Reserved_Block_Count "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Ave_Block-Erase_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 180,raw48,Unused_Reserve_NAND_Blk "
    "-v 183,raw48,SATA_Interfac_Downshift "
    "-v 184,raw48,Error_Correction_Count "
    "-v 195,raw48,Cumulativ_Corrected_ECC "
  //"-v 187,raw48,Reported_Uncorrect "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 196,raw16(raw16),Reallocated_Event_Count "
  //"-v 197,raw48,Current_Pending_Sector "
  //"-v 198,raw48,Offline_Uncorrectable "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
    "-v 202,raw48,Percent_Lifetime_Used "
    "-v 206,raw48,Write_Error_Rate "
    "-v 210,raw48,Success_RAIN_Recov_Cnt "
    "-v 246,raw48,Total_Host_Sector_Write "
    "-v 247,raw48,Host_Program_Page_Count "
    "-v 248,raw48,Bckgnd_Program_Page_Cnt"
  },
  { "Micron M500DC/M510DC Enterprise SSDs",
    "Micron_M500DC_(EE|MT)FDDA[AK](120|240|480|800)MBB|" // tested with
      // Micron_M500DC_EEFDDAA120MBB/129, Micron_M500DC_MTFDDAK800MBB/0129
    "MICRON_M510DC_(EE|MT)FDDAK(120|240|480|800|960)MBP", // tested with
      // Micron_M510DC_MTFDDAK240MBP/0005
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
    "-v 5,raw48,Reallocated_Block_Count "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Reserved_Block_Count "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Ave_Block-Erase_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 184,raw48,Error_Correction_Count "
  //"-v 187,raw48,Reported_Uncorrect "
    "-v 188,raw48,Command_Timeouts "
  //"-v 194,tempminmax,Temperature_Celsius "
    "-v 195,raw48,Cumulativ_Corrected_ECC "
  //"-v 197,raw48,Current_Pending_Sector "
  //"-v 198,raw48,Offline_Uncorrectable "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
    "-v 202,raw48,Percent_Lifetime_Remain "
    "-v 206,raw48,Write_Error_Rate "
    "-v 247,raw48,Host_Program_Page_Count "
    "-v 248,raw48,Bckgnd_Program_Page_Cnt"
  },
  { "SandForce Driven SSDs", // Corsair Force LS with buggy firmware only
    "Corsair Force LS SSD", // tested with Corsair Force LS SSD/S9FM01.8
    "S9FM01\\.8",
    "A firmware update is available for this drive.\n"
    "It is HIGHLY RECOMMENDED for drives with specific serial numbers.\n"
    "See the following web pages for details:\n"
    "http://www.corsair.com/en-us/force-series-ls-60gb-sata-3-6gb-s-ssd\n"
    "https://www.smartmontools.org/ticket/628",
    "-v 1,raw24/raw32,Raw_Read_Error_Rate "
    "-v 5,raw48,Retired_Block_Count "
    "-v 9,msec24hour32,Power_On_Hours_and_Msec "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 162,raw48,Unknown_SandForce_Attr "
    "-v 170,raw48,Reserve_Block_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Unknown_SandForce_Attr "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 181,raw48,Program_Fail_Count "
  //"-v 187,raw48,Reported_Uncorrect "
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 196,raw16(raw16),Reallocated_Event_Count "
    "-v 218,raw48,Unknown_SandForce_Attr "
    "-v 231,raw48,SSD_Life_Left "
    "-v 241,raw48,Lifetime_Writes_GiB "
    "-v 242,raw48,Lifetime_Reads_GiB"
  },
  { "SandForce Driven SSDs",
    "SandForce 1st Ed\\.|" // Demo Drive, tested with firmware 320A13F0
    "ADATA SSD S(396|510|599) .?..GB|" // tested with ADATA SSD S510 60GB/320ABBF0,
      // ADATA SSD S599 256GB/3.1.0, 64GB/3.4.6
    "ADATA SP[389]00|" // tested with ADATA SP300/5.0.2d, SP800/5.0.6c,
      // ADATA SP900/5.0.6 (Premier Pro, SF-2281)
    "ADATA SSD S[PX]900 (64|128|256|512)GB-DL2|" // tested with ADATA SSD SP900 256GB-DL2/5.0.6,
      // ADATA SSD SX900 512GB-DL2/5.8.2
    "ADATA XM11 (128|256)GB|" // tested with ADATA XM11 128GB/5.0.1
    "ATP Velocity MIV (60|120|240|480)GB|" // tested with ATP Velocity MIV 480GB/110719
    "Corsair CSSD-F(40|60|80|115|120|160|240)GBP?2.*|" // Corsair Force, tested with
      // Corsair CSSD-F40GB2/1.1, Corsair CSSD-F115GB2-A/2.1a
    "Corsair Voyager GTX|" // Corsair Voyager GTX/S9FM02J6
    "Corsair Force ((3 |LS )?SSD|GS|GT)|" // SF-2281, tested with
      // Corsair Force SSD/5.05, 3 SSD/1.3.2, GT/1.3.3, GS/5.03,
      // Corsair Force LS SSD/S8FM06.5, S9FM01.8, S9FM02.0
    "FM-25S2S-(60|120|240)GBP2|" // G.SKILL Phoenix Pro, SF-1200, tested with
      // FM-25S2S-240GBP2/4.2
    "FTM(06|12|24|48)CT25H|" // Supertalent TeraDrive CT, tested with
      // FTM24CT25H/STTMP2P1
    "KINGSTON SE50S3(100|240|480)G|" // tested with SE50S3100G/KE1ABBF0
    "KINGSTON SH10[03]S3(90|120|240|480)G|" // HyperX (3K), SF-2281, tested with
      // SH100S3240G/320ABBF0, SH103S3120G/505ABBF0
    "KINGSTON SKC(300S37A|380S3)(60|120|180|240|480)G|" // KC300, SF-2281, tested with
      // SKC300S37A120G/KC4ABBF0, SKC380S3120G/507ABBF0
    "KINGSTON SVP200S3(7A)?(60|90|120|240|480)G|" // V+ 200, SF-2281, tested with
      // SVP200S37A480G/502ABBF0, SVP200S390G/332ABBF0
    "KINGSTON SMS200S3(30|60|120)G|" // mSATA, SF-2241, tested with SMS200S3120G/KC3ABBF0
    "KINGSTON SMS450S3(32|64|128)G|" // mSATA, SF-2281, tested with SMS450S3128G/503ABBF0
    "KINGSTON (SV300|SKC100|SE100)S3.*G|" // other SF-2281
    "MKNSSDCR(45|60|90|120|180|240|360|480)GB(-(7|DX7?|MX|G2))?|" // Mushkin Chronos (7mm/Deluxe/MX/G2),
      // SF-2281, tested with MKNSSDCR120GB, MKNSSDCR120GB-MX/560ABBF0, MKNSSDCR480GB-DX7/603ABBF0
    "MKNSSDEC(60|120|240|480|512)GB|" // Mushkin Enhanced ECO2, tested with MKNSSDEC120GB/604ABBF0
    "MKNSSDAT(30|40|60|120|180|240|480)GB(-(DX|V))?|" // Mushkin Atlas (Deluxe/Value), mSATA, SF-2281,
      // tested with MKNSSDAT120GB-V/540ABBF0
    "Mushkin MKNSSDCL(40|60|80|90|115|120|180|240|480)GB-DX2?|" // Mushkin Callisto deluxe,
      // SF-1200/1222, Mushkin MKNSSDCL60GB-DX/361A13F0
    "OCZ[ -](AGILITY2([ -]EX)?|COLOSSUS2|ONYX2|VERTEX(2|-LE))( [123]\\..*)?|" // SF-1200,
      // tested with OCZ-VERTEX2/1.11, OCZ-VERTEX2 3.5/1.11
    "OCZ-NOCTI|" // mSATA, SF-2100, tested with OCZ-NOCTI/2.15
    "OCZ-REVODRIVE3?( X2)?|" // PCIe, SF-1200/2281, tested with
      // OCZ-REVODRIVE( X2)?/1.20, OCZ-REVODRIVE3 X2/2.11
    "OCZ-REVODRIVE350|"
    "OCZ[ -](VELO|VERTEX2[ -](EX|PRO))( [123]\\..*)?|" // SF-1500, tested with
      // OCZ VERTEX2-PRO/1.10 (Bogus thresholds for attribute 232 and 235)
    "D2[CR]STK251...-....|" // OCZ Deneva 2 C/R, SF-22xx/25xx,
      // tested with D2CSTK251M11-0240/2.08, D2CSTK251A10-0240/2.15
    "OCZ-(AGILITY3|SOLID3|VERTEX3( MI)?)|"  // SF-2200, tested with OCZ-VERTEX3/2.02,
      // OCZ-AGILITY3/2.11, OCZ-SOLID3/2.15, OCZ-VERTEX3 MI/2.15
    "OCZ Z-DRIVE R4 [CR]M8[48]|" // PCIe, SF-2282/2582, tested with OCZ Z-DRIVE R4 CM84/2.13
      // (Bogus attributes under Linux)
    "OCZ Z-DRIVE 4500|"
    "OCZ-VELO DRIVE|" // VeloDrive R, PCIe, tested with OCZ-VELO DRIVE/1.33
    "TALOS2|" // OCZ Talos 2 C/R, SAS (works with -d sat), 2*SF-2282, tested with TALOS2/3.20E
    "(APOC|DENC|DENEVA|FTNC|GFGC|MANG|MMOC|NIMC|TMSC).*|" // other OCZ SF-1200,
      // tested with DENCSTE251M11-0120/1.33, DENEVA PCI-E/1.33
    "(DENR|DRSAK|EC188|NIMR|PSIR|TRSAK).*|" // other OCZ SF-1500
    "OWC Aura Pro( 6G SSD)?|" // tested with OWC Aura Pro 6G SSD/507ABBF0, OWC Aura Pro/603ABBF0
    "OWC Mercury Electra (Pro )?[36]G SSD|" // tested with
      // OWC Mercury Electra 6G SSD/502ABBF0, OWC Mercury Electra Pro 3G SSD/541ABBF0
    "OWC Mercury E(xtreme|XTREME) Pro (6G |RE )?SSD|" // tested with
      // OWC Mercury Extreme Pro SSD/360A13F0, OWC Mercury EXTREME Pro 6G SSD/507ABBF0
    "Patriot Pyro|" // tested with Patriot Pyro/332ABBF0
    "SanDisk SDSSDX(60|120|240|480)GG25|" // SanDisk Extreme, SF-2281, tested with
      // SDSSDX240GG25/R201
    "SanDisk SDSSDA(120|240|480)G|" // SanDisk SSD Plus, tested with SanDisk SDSSDA240G/U21010RL
    "SuperSSpeed S301 [0-9]*GB|" // SF-2281, tested with SuperSSpeed S301 128GB/503
    "SG9XCS2D(0?50|100|200|400)GESLT|" // Smart Storage Systems XceedIOPS2, tested with
      // SG9XCS2D200GESLT/SA03L370
    "SSD9SC(120|240|480)GED[EA]|" // PNY Prevail Elite, tested with SSD9SC120GEDA/334ABBF0
    "(TX32|TX31C1|VN0.?..GCNMK).*|" // Smart Storage Systems XceedSTOR
    "(TX22D1|TX21B1).*|" // Smart Storage Systems XceedIOPS2
    "TX52D1.*|" // Smart Storage Systems Xcel-200
    "TS(64|128|256|512)GSSD[37]20|" // Transcend SSD320/720, SF-2281, tested with
      // TS128GSSD320, TS256GSSD720/5.2.0
    "UGB(88P|99S)GC...H[BF].|" // Unigen, tested with
      // UGB88PGC100HF2/MP Rev2, UGB99SGC100HB3/RC Rev3
    "SG9XCS(1F|2D)(50|100|200|400)GE01|" // XceedIOPS, tested with SG9XCS2D50GE01/SA03F34V
    "VisionTek GoDrive (60|120|240|480)GB", // tested with VisionTek GoDrive 480GB/506ABBF0
    "", "",
    "-v 1,raw24/raw32,Raw_Read_Error_Rate "
    "-v 5,raw48,Retired_Block_Count "
    "-v 9,msec24hour32,Power_On_Hours_and_Msec "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 13,raw24/raw32,Soft_Read_Error_Rate "
    "-v 100,raw48,Gigabytes_Erased "
    "-v 162,raw48,Unknown_SandForce_Attr " // Corsair Force LS SSD/S9FM01.8, *2.0
    "-v 170,raw48,Reserve_Block_Count "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Unknown_SandForce_Attr " // Corsair Force LS SSD/S9FM01.8, *2.0
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 177,raw48,Wear_Range_Delta "
    "-v 181,raw48,Program_Fail_Count "
    "-v 182,raw48,Erase_Fail_Count "
    "-v 184,raw48,IO_Error_Detect_Code_Ct "
  //"-v 187,raw48,Reported_Uncorrect "
    "-v 189,tempminmax,Airflow_Temperature_Cel "
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 194,tempminmax,Temperature_Celsius "
    "-v 195,raw24/raw32,ECC_Uncorr_Error_Count "
  //"-v 196,raw16(raw16),Reallocated_Event_Count "
    "-v 198,raw24/raw32:210zr54,Uncorrectable_Sector_Ct " // KINGSTON SE100S3100G/510ABBF0
    "-v 199,raw48,SATA_CRC_Error_Count "
    "-v 201,raw24/raw32,Unc_Soft_Read_Err_Rate "
    "-v 204,raw24/raw32,Soft_ECC_Correct_Rate "
    "-v 218,raw48,Unknown_SandForce_Attr " // Corsair Force LS SSD/S9FM01.8, *2.0
    "-v 230,raw48,Life_Curve_Status "
    "-v 231,raw48,SSD_Life_Left "
  //"-v 232,raw48,Available_Reservd_Space "
    "-v 233,raw48,SandForce_Internal "
    "-v 234,raw48,SandForce_Internal "
    "-v 235,raw48,SuperCap_Health "
    "-v 241,raw48,Lifetime_Writes_GiB "
    "-v 242,raw48,Lifetime_Reads_GiB"
  },
  {
    "StorFly CFast SATA 6Gbps SSDs",
    // http://datasheet.octopart.com/VSFCS2CC060G-100-Virtium-datasheet-82287733.pdf
    // tested with StorFly VSFCS2CC060G-100/0409-000
    "StorFly VSFCS2C[CI](016|030|060|120|240)G-...",
    // C - commercial, I industrial
    "", "",
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 160,raw48,Uncorrectable_Error_Cnt "
    // 0729 - remaining in block life. In 0828  remaining is normalized to 100% then decreases
    "-v 161,raw48,Spares_Remaining " 
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB "
    "-v 169,raw48,Lifetime_Remaining% "
    "-v 248,raw48,Lifetime_Remaining% " //  later then 0409 FW.
    "-v 249,raw48,Spares_Remaining_Perc " //  later then 0409 FW.
  },
  { "Phison Driven SSDs", // see MKP_521_Phison_SMART_attribute.pdf
    "KINGSTON SUV300S37A(120|240|480)G|" // UV300 SSD, tested with KINGSTON SUV300S37A120G/SAFM11.K
    "KINGSTON SKC310S3B?7A960G|" // SSDNow KC310, KINGSTON SKC310S37A960G/SAFM00.r
    "KINGSTON SKC400S37(128G|256G|512G|1T)|" // SSDNow KC400, KINGSTON SKC400S37128G
    "KINGSTON SV310S3(7A|D7|N7A|B7A)960G|" // SSDNow V310
    "GOODRAM|" // GOODRAM/SAFM12.2 (CX200), model name is missing in the SMART!
    "PNY CS1311 (120|240|480|960)GB SSD|" // tested with PNY CS1311 120GB SSD/CS131122
    "KINGSTON SHSS3B?7A(120|240|480|960)G", // HyperX Savage
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
    "-v 2,raw48,Not_In_Use "
    "-v 3,raw48,Not_In_Use "
    "-v 5,raw48,Not_In_Use "
    "-v 7,raw48,Not_In_Use "
    "-v 8,raw48,Not_In_Use "
  //"-v 9,raw24(raw8),Power_On_Hours "
    "-v 5,raw48,Retired_Block_Count "
  //"-v 9,raw24(raw8),Power_On_Hours "
    "-v 10,raw48,Not_In_Use "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 168,raw48,SATA_Phy_Error_Count "
    "-v 170,raw24/raw24:z54z10,Bad_Blk_Ct_Erl/Lat " // Early bad block/Later bad block
    "-v 173,raw16(avg16),MaxAvgErase_Ct "
    "-v 175,raw48,Not_In_Use "
    "-v 183,raw48,Unknown_Attribute "
  //"-v 187,raw48,Reported_Uncorrect "
    "-v 192,raw48,Unsafe_Shutdown_Count "
  //"-v 194,tempminmax,Temperature_Celsius "
    "-v 196,raw48,Not_In_Use "
    "-v 197,raw48,Not_In_Use "
    "-v 199,raw48,CRC_Error_Count "
    "-v 218,raw48,CRC_Error_Count "
    "-v 231,raw48,SSD_Life_Left "
    "-v 233,raw48,Flash_Writes_GiB "
    "-v 240,raw48,Not_In_Use "
    "-v 241,raw48,Lifetime_Writes_GiB "
    "-v 242,raw48,Lifetime_Reads_GiB "
    "-v 244,raw48,Average_Erase_Count "
    "-v 245,raw48,Max_Erase_Count "
    "-v 246,raw48,Total_Erase_Count "
  },
  // this is a copy of the Phison bases record for the OEM drives with a very
  // weak information in the model. Detection is based on Firmware.
  // Tested with FoxLine flssd240x4se (SATA SSD/SBFM10.5) and Supermicro 
  // SSD-DM032-PHI (SATA SSD/S9FM02.1)
  { "Phison Driven OEM SSDs", // see MKP_521_Phison_SMART_attribute.pdf
    "SATA SSD",
    "(S9FM02\\.1|SBFM10\\.5)",
    "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
    "-v 2,raw48,Not_In_Use "
    "-v 3,raw48,Not_In_Use "
    "-v 5,raw48,Not_In_Use "
    "-v 7,raw48,Not_In_Use "
    "-v 8,raw48,Not_In_Use "
  //"-v 9,raw24(raw8),Power_On_Hours "
    "-v 5,raw48,Retired_Block_Count "
  //"-v 9,raw24(raw8),Power_On_Hours "
    "-v 10,raw48,Not_In_Use "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 168,raw48,SATA_Phy_Error_Count "
    "-v 170,raw24/raw24:z54z10,Bad_Blk_Ct_Erl/Lat " // Early bad block/Later bad block
    "-v 173,raw16(avg16),MaxAvgErase_Ct "
    "-v 175,raw48,Not_In_Use "
    "-v 183,raw48,Unknown_Attribute "
  //"-v 187,raw48,Reported_Uncorrect "
    "-v 192,raw48,Unsafe_Shutdown_Count "
  //"-v 194,tempminmax,Temperature_Celsius "
    "-v 196,raw48,Not_In_Use "
    "-v 197,raw48,Not_In_Use "
    "-v 199,raw48,CRC_Error_Count "
    "-v 218,raw48,CRC_Error_Count "
    "-v 231,raw48,SSD_Life_Left "
    "-v 233,raw48,Flash_Writes_GiB "
    "-v 240,raw48,Not_In_Use "
    "-v 241,raw48,Lifetime_Writes_GiB "
    "-v 242,raw48,Lifetime_Reads_GiB "
    "-v 244,raw48,Average_Erase_Count "
    "-v 245,raw48,Max_Erase_Count "
    "-v 246,raw48,Total_Erase_Count "
  },
  { "Indilinx Barefoot based SSDs",
    "Corsair CSSD-V(32|60|64|128|256)GB2|" // Corsair Nova, tested with Corsair CSSD-V32GB2/2.2
    "Corsair CMFSSD-(32|64|128|256)D1|" // Corsair Extreme, tested with Corsair CMFSSD-128D1/1.0
    "CRUCIAL_CT(64|128|256)M225|" // tested with CRUCIAL_CT64M225/1571
    "G.SKILL FALCON (64|128|256)GB SSD|" // tested with G.SKILL FALCON 128GB SSD/2030
    "OCZ[ -](AGILITY|ONYX|VERTEX( 1199|-TURBO| v1\\.10)?)|" // tested with
      // OCZ-ONYX/1.6, OCZ-VERTEX 1199/00.P97, OCZ-VERTEX/1.30, OCZ VERTEX-TURBO/1.5, OCZ-VERTEX v1.10/1370
    "Patriot[ -]Torqx.*|"
    "RENICE Z2|" // tested with RENICE Z2/2030
    "STT_FT[MD](28|32|56|64)GX25H|" // Super Talent Ultradrive GX, tested with STT_FTM64GX25H/1916
    "TS(18|25)M(64|128)MLC(16|32|64|128|256|512)GSSD|" // ASAX Leopard Hunt II, tested with TS25M64MLC64GSSD/0.1
    "FM-25S2I-(64|128)GBFII|" // G.Skill FALCON II, tested with FM-25S2I-64GBFII
    "TS(60|120)GSSD25D-M", // Transcend Ultra SSD (SATA II), see also Ticket #80
    "", "",
    "-v 1,raw64 " // Raw_Read_Error_Rate
    "-v 9,raw64 " // Power_On_Hours
    "-v 12,raw64 " // Power_Cycle_Count
    "-v 184,raw64,Initial_Bad_Block_Count "
    "-v 195,raw64,Program_Failure_Blk_Ct "
    "-v 196,raw64,Erase_Failure_Blk_Ct "
    "-v 197,raw64,Read_Failure_Blk_Ct "
    "-v 198,raw64,Read_Sectors_Tot_Ct "
    "-v 199,raw64,Write_Sectors_Tot_Ct "
    "-v 200,raw64,Read_Commands_Tot_Ct "
    "-v 201,raw64,Write_Commands_Tot_Ct "
    "-v 202,raw64,Error_Bits_Flash_Tot_Ct "
    "-v 203,raw64,Corr_Read_Errors_Tot_Ct "
    "-v 204,raw64,Bad_Block_Full_Flag "
    "-v 205,raw64,Max_PE_Count_Spec "
    "-v 206,raw64,Min_Erase_Count "
    "-v 207,raw64,Max_Erase_Count "
    "-v 208,raw64,Average_Erase_Count "
    "-v 209,raw64,Remaining_Lifetime_Perc "
    "-v 210,raw64,Indilinx_Internal "
    "-v 211,raw64,SATA_Error_Ct_CRC "
    "-v 212,raw64,SATA_Error_Ct_Handshake "
    "-v 213,raw64,Indilinx_Internal"
  },
  { "Indilinx Barefoot_2/Everest/Martini based SSDs",
    "OCZ VERTEX[ -]PLUS|" // tested with OCZ VERTEX-PLUS/3.55, OCZ VERTEX PLUS/3.55
    "OCZ-VERTEX PLUS R2|" // Barefoot 2, tested with OCZ-VERTEX PLUS R2/1.2
    "OCZ-PETROL|" // Everest 1, tested with OCZ-PETROL/3.12
    "OCZ-AGILITY4|" // Everest 2, tested with OCZ-AGILITY4/1.5.2
    "OCZ-VERTEX4", // Everest 2, tested with OCZ-VERTEX4/1.5
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 4,raw48,Start_Stop_Count "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 232,raw48,Lifetime_Writes " // LBA?
  //"-v 233,raw48,Media_Wearout_Indicator"
  },
  { "Indilinx Barefoot 3 based SSDs",
    "OCZ-VECTOR(1[58]0)?|" // tested with OCZ-VECTOR/1.03, OCZ-VECTOR150/1.2, OCZ-VECTOR180
    "OCZ-VERTEX4[56]0A?|" // Barefoot 3 M10, tested with OCZ-VERTEX450/1.0, OCZ-VERTEX460/1.0, VERTEX460A
    "OCZ-SABER1000|"
    "OCZ-ARC100|"
    "Radeon R7", // Barefoot 3 M00, tested with Radeon R7/1.00
    "", "",
    "-v 5,raw48,Runtime_Bad_Block "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 171,raw48,Avail_OP_Block_Count "
    "-v 174,raw48,Pwr_Cycle_Ct_Unplanned "
    "-v 187,raw48,Total_Unc_NAND_Reads "
    "-v 195,raw48,Total_Prog_Failures "
    "-v 196,raw48,Total_Erase_Failures "
    "-v 197,raw48,Total_Unc_Read_Failures "
    "-v 198,raw48,Host_Reads_GiB "
    "-v 199,raw48,Host_Writes_GiB "
    "-v 205,raw48,Max_Rated_PE_Count "
    "-v 206,raw48,Min_Erase_Count "
    "-v 207,raw48,Max_Erase_Count "
    "-v 208,raw48,Average_Erase_Count "
    "-v 210,raw48,SATA_CRC_Error_Count "
    "-v 212,raw48,Pages_Requiring_Rd_Rtry "
    "-v 213,raw48,Snmple_Retry_Attempts "
    "-v 214,raw48,Adaptive_Retry_Attempts "
    "-v 222,raw48,RAID_Recovery_Count "
    "-v 224,raw48,In_Warranty "
    "-v 225,raw48,DAS_Polarity "
    "-v 226,raw48,Partial_Pfail "
    "-v 230,raw48,Write_Throttling "
    "-v 233,raw48,Remaining_Lifetime_Perc "
    "-v 241,raw48,Host_Writes_GiB " // M00/M10
    "-v 242,raw48,Host_Reads_GiB "  // M00/M10
    "-v 249,raw48,Total_NAND_Prog_Ct_GiB "
    "-v 251,raw48,Total_NAND_Read_Ct_GiB"
  },
  { "OCZ Intrepid 3000 SSDs", // tested with OCZ INTREPID 3600/1.4.3.6, 3800/1.4.3.0, 3700/1.5.0.4
    "OCZ INTREPID 3[678]00",
    "", "",
    "-v 5,raw48,Runtime_Bad_Block "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 100,raw48,Total_Blocks_Erased "
    "-v 171,raw48,Avail_OP_Block_Count "
    "-v 174,raw48,Pwr_Cycle_Ct_Unplanned "
    "-v 184,raw48,Factory_Bad_Block_Count "
    "-v 187,raw48,Total_Unc_NAND_Reads "
    "-v 190,tempminmax,Temperature_Celsius "
    "-v 195,raw48,Total_Prog_Failures "
    "-v 196,raw48,Total_Erase_Failures "
    "-v 197,raw48,Total_Unc_Read_Failures "
    "-v 198,raw48,Host_Reads_GiB "
    "-v 199,raw48,Host_Writes_GiB "
    "-v 202,raw48,Total_Read_Bits_Corr_Ct "
    "-v 205,raw48,Max_Rated_PE_Count "
    "-v 206,raw48,Min_Erase_Count "
    "-v 207,raw48,Max_Erase_Count "
    "-v 208,raw48,Average_Erase_Count "
    "-v 210,raw48,SATA_CRC_Error_Count "
    "-v 211,raw48,SATA_UNC_Count "
    "-v 212,raw48,NAND_Reads_with_Retry "
    "-v 213,raw48,Simple_Rd_Rtry_Attempts "
    "-v 214,raw48,Adaptv_Rd_Rtry_Attempts "
    "-v 221,raw48,Int_Data_Path_Prot_Unc "
    "-v 222,raw48,RAID_Recovery_Count "
    "-v 230,raw48,SuperCap_Charge_Status " // 0=not charged, 1=fully charged, 2=unknown
    "-v 233,raw48,Remaining_Lifetime_Perc "
    "-v 249,raw48,Total_NAND_Prog_Ct_GiB "
    "-v 251,raw48,Total_NAND_Read_Ct_GiB"
  },
  {
    "OCZ/Toshiba Trion SSDs",
    "OCZ-TRION1[05]0|" // tested with OCZ-TRION100/SAFM11.2A, TRION150/SAFZ72.2
    "TOSHIBA-TR150", // tested with TOSHIBA-TR150/SAFZ12.3
    "", "",
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 167,raw48,SSD_Protect_Mode "
    "-v 168,raw48,SATA_PHY_Error_Count "
    "-v 169,raw48,Bad_Block_Count "
    "-v 173,raw48,Erase_Count "
    "-v 192,raw48,Unexpect_Power_Loss_Ct "
  //"-v 194,tempminmax,Temperature_Celsius "
    "-v 241,raw48,Host_Writes"
  },
  { "InnoDisk InnoLite SATADOM D150QV-L SSDs", // tested with InnoLite SATADOM D150QV-L/120319
    "InnoLite SATADOM D150QV-L",
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 2,raw48,Throughput_Performance "
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 7,raw48,Seek_Error_Rate " // from InnoDisk iSMART Linux tool, useless for SSD
  //"-v 8,raw48,Seek_Time_Performance "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 10,raw48,Spin_Retry_Count "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 168,raw48,SATA_PHY_Error_Count "
    "-v 170,raw48,Bad_Block_Count "
    "-v 173,raw48,Erase_Count "
    "-v 175,raw48,Bad_Cluster_Table_Count "
    "-v 192,raw48,Unexpect_Power_Loss_Ct "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 197,raw48,Current_Pending_Sector "
    "-v 229,hex48,Flash_ID "
    "-v 235,raw48,Later_Bad_Block "
    "-v 236,raw48,Unstable_Power_Count "
    "-v 240,raw48,Write_Head"
  },
  { "Innodisk 1ME3/3ME/3SE SSDs", // tested with 2.5" SATA SSD 3ME/S140714,
      // Mini PCIeDOM 1ME3/S15604, InnoDisk Corp. - mSATA 3SE/S130710
    "((1\\.8|2\\.5)\"? SATA SSD|InnoDisk Corp\\. - mSATA|Mini PCIeDOM|SATA Slim) (1ME3|3[MS]E)",
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 2,raw48,Throughput_Performance "
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 5,raw48,Reallocated_Sector_Count "
    "-v 7,raw48,Seek_Error_Rate "       // ?
    "-v 8,raw48,Seek_Time_Performance " // ?
  //"-v 9,raw24(raw8),Power_On_Hours "
    "-v 10,raw48,Spin_Retry_Count "     // ?
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 168,raw48,SATA_PHY_Error_Count "
    "-v 169,hex48,Unknown_Innodisk_Attr "
    "-v 170,raw16,Bad_Block_Count "
    "-v 173,raw16,Erase_Count "
    "-v 175,raw48,Bad_Cluster_Table_Count "
    "-v 176,raw48,Uncorr_RECORD_Count "
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 194,tempminmax,Temperature_Celsius " // ] only in spec
  //"-v 197,raw48,Current_Pending_Sector "
    "-v 225,raw48,Unknown_Innodisk_Attr "
    "-v 229,hex48,Flash_ID "
    "-v 235,raw48,Later_Bad_Block "
    "-v 236,raw48,Unstable_Power_Count "
    "-v 240,raw48,Write_Head"
  },
  { "Innodisk 3IE2/3ME2/3MG2/3SE2 SSDs", // tested with 2.5" SATA SSD 3MG2-P/M140402,
      // 1.8 SATA SSD 3IE2-P/M150821, 2.5" SATA SSD 3IE2-P/M150821,
      // SATA Slim 3MG2-P/M141114, M.2 (S80) 3MG2-P/M141114, M.2 (S42) 3SE2-P/M150821,
      // M.2 (S42) 3ME2/M151013
    "((1\\.8|2\\.5)\"? SATA SSD|SATA Slim|M\\.2 \\(S(42|80)\\)) 3(IE|ME|MG|SE)2(-P)?",
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 2,raw48,Throughput_Performance "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 160,raw48,Uncorrectable_Error_Cnt "
    "-v 161,raw48,Number_of_Pure_Spare "
    "-v 163,raw48,Initial_Bad_Block_Count "
    "-v 164,raw48,Total_Erase_Count "
    "-v 165,raw48,Max_Erase_Count "
    "-v 166,raw48,Min_Erase_Count "
    "-v 167,raw48,Average_Erase_Count "
    "-v 168,raw48,Max_Erase_Count_of_Spec "
    "-v 169,raw48,Remaining_Lifetime_Perc "
  //"-v 175,raw48,Program_Fail_Count_Chip "
  //"-v 176,raw48,Erase_Fail_Count_Chip "
  //"-v 177,raw48,Wear_Leveling_Count "
    "-v 178,raw48,Runtime_Invalid_Blk_Cnt "
  //"-v 181,raw48,Program_Fail_Cnt_Total "
  //"-v 182,raw48,Erase_Fail_Count_Total "
  //"-v 187,raw48,Reported_Uncorrect " // ] only in spec
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 195,raw48,Hardware_ECC_Recovered "
  //"-v 196,raw16(raw16),Reallocated_Event_Count "
  //"-v 197,raw48,Current_Pending_Sector "
  //"-v 198,raw48,Offline_Uncorrectable "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
    "-v 225,raw48,Host_Writes_32MiB "  // ]
  //"-v 232,raw48,Available_Reservd_Space "
    "-v 233,raw48,Flash_Writes_32MiB " // ]
    "-v 234,raw48,Flash_Reads_32MiB "  // ]
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB "
    "-v 245,raw48,Flash_Writes_32MiB"
  },
  { "Innodisk 3IE3/3ME3/3ME4 SSDs", // tested with 2.5" SATA SSD 3ME3/S15A19, CFast 3ME3/S15A19
      // InnoDisk Corp. - mSATA 3ME3/S15A19, mSATA mini 3ME3/S15A19, M.2 (S42) 3ME3,
      // SATA Slim 3ME3/S15A19, SATADOM-MH 3ME3/S15A19, SATADOM-ML 3ME3/S15A19,
      // SATADOM-MV 3ME3/S15A19, SATADOM-SL 3ME3/S15A19, SATADOM-SV 3ME3/S15A19,
      // SATADOM-SL 3IE3/S151019N, 2.5" SATA SSD 3IE3/S15C14i, CFast 3IE3/S15C14i,
      // InnoDisk Corp. - mSATA 3IE3/S15C14i, Mini PCIeDOM 1IE3/S15C14i,
      // mSATA mini 3IE3/S15C14i, M.2 (S42) 3IE3/S15C14i, SATA Slim 3IE3/S15C14i,
      // SATADOM-SH 3IE3 V2/S15C14i, SATADOM-SL 3IE3 V2/S15A19i, SATADOM-SV 3IE3 V2/S15C14i
      // mSATA 3ME4/L16711, M.2 (S42) 3ME4/L16711, SATADOM-MH 3ME4/L16B01,
      // SATADOM-SH 3ME4/L16B01, SATADOM-SH Type C 3ME4/L16B01, SATADOM-SH Type D 3ME4/L16B01
    "(2.5\" SATA SSD|CFast|InnoDisk Corp\\. - mSATA|Mini PCIeDOM|mSATA( mini)?|"
    "M\\.2 \\(S42\\)|SATA Slim|SATADOM-[MS][HLV]( Type [CD])?) 3([IM]E3|ME4)( V2)?",
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 2,raw48,Throughput_Performance "
  //"-v 3,raw16(avg16),Spin_Up_Time "
    "-v 5,raw48,Later_Bad_Block "
    "-v 7,raw48,Seek_Error_Rate "       // ?
    "-v 8,raw48,Seek_Time_Performance " // ?
  //"-v 9,raw24(raw8),Power_On_Hours "
    "-v 10,raw48,Spin_Retry_Count "     // ?
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 163,raw48,Total_Bad_Block_Count "
    "-v 165,raw48,Max_Erase_Count "
    "-v 167,raw48,Average_Erase_Count "
    "-v 168,raw48,SATA_PHY_Error_Count "
    "-v 169,raw48,Remaining_Lifetime_Perc "
    "-v 170,raw48,Spare_Block_Count "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 175,raw48,Bad_Cluster_Table_Count "
    "-v 176,raw48,RANGE_RECORD_Count "
  //"-v 187,raw48,Reported_Uncorrect "
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 197,raw48,Current_Pending_Sector "
    "-v 225,raw48,Data_Log_Write_Count "
    "-v 229,hex48,Flash_ID "
    "-v 232,raw48,Spares_Remaining_Perc "
    "-v 235,raw16,Later_Bad_Blk_Inf_R/W/E " // Read/Write/Erase
    "-v 240,raw48,Write_Head "
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB"
  },
  { "InnoDisk iCF 9000 CompactFlash Cards", // tested with InnoDisk Corp. - iCF9000 1GB/140808,
       // ..., InnoDisk Corp. - iCF9000 64GB/140808
    "InnoDisk Corp\\. - iCF9000 (1|2|4|8|16|32|64)GB",
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 160,raw48,Uncorrectable_Error_Cnt "
    "-v 161,raw48,Valid_Spare_Block_Cnt "
    "-v 162,raw48,Child_Pair_Count "
    "-v 163,raw48,Initial_Bad_Block_Count "
    "-v 164,raw48,Total_Erase_Count "
    "-v 165,raw48,Max_Erase_Count "
    "-v 166,raw48,Min_Erase_Count "
    "-v 167,raw48,Average_Erase_Count "
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 195,raw48,Hardware_ECC_Recovered "
  //"-v 196,raw16(raw16),Reallocated_Event_Count "
  //"-v 198,raw48,Offline_Uncorrectable "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
  //"-v 229,raw48,Flash_ID " // only in spec
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB"
  },
  { "Intel X25-E SSDs",
    "SSDSA2SH(032|064)G1.* INTEL",  // G1 = first generation
    "", "",
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 4,raw48,Start_Stop_Count "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Intel_Internal "
    "-v 227,raw48,Intel_Internal "
    "-v 228,raw48,Intel_Internal "
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator"
  },
  { "Intel X18-M/X25-M G1 SSDs",
    "INTEL SSDSA[12]MH(080|160)G1.*",  // G1 = first generation, 50nm
    "", "",
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 4,raw48,Start_Stop_Count "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Intel_Internal "
    "-v 227,raw48,Intel_Internal "
    "-v 228,raw48,Intel_Internal "
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator"
  },
  { "Intel X18-M/X25-M/X25-V G2 SSDs", // fixed firmware
      // tested with INTEL SSDSA2M(080|160)G2GC/2CV102J8 (X25-M)
    "INTEL SSDSA[12]M(040|080|120|160)G2.*",  // G2 = second generation, 34nm
    "2CV102(J[89A-Z]|[K-Z].)", // >= "2CV102J8"
    "",
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 4,raw48,Start_Stop_Count "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
  //"-v 184,raw48,End-to-End_Error " // G2 only
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic " // Timed Workload Media Wear Indicator (percent*1024)
    "-v 227,raw48,Workld_Host_Reads_Perc "  // Timed Workload Host Reads Percentage
    "-v 228,raw48,Workload_Minutes " // 226,227,228 can be reset by 'smartctl -t vendor,0x40'
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator"
  },
  { "Intel X18-M/X25-M/X25-V G2 SSDs", // buggy or unknown firmware
      // tested with INTEL SSDSA2M040G2GC/2CV102HD (X25-V)
    "INTEL SSDSA[12]M(040|080|120|160)G2.*",
    "",
    "This drive may require a firmware update to\n"
    "fix possible drive hangs when reading SMART self-test log:\n"
    "http://downloadcenter.intel.com/Detail_Desc.aspx?DwnldID=18363",
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic "
    "-v 227,raw48,Workld_Host_Reads_Perc "
    "-v 228,raw48,Workload_Minutes"
  },
  { "Intel 311/313 Series SSDs", // tested with INTEL SSDSA2VP020G2/2CV102M5,
      // INTEL SSDSA2VP020G3/9CV10379, INTEL SSDMAEXC024G3H/9CV10379
    "INTEL SSD(SA2VP|MAEXC)(020|024)G[23]H?",
      // SA2VP = 2.5", MAEXC = mSATA, G2 = 311, G3 = 313
    "", "",
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 4,raw48,Start_Stop_Count "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Reserve_Block_Count "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 183,raw48,SATA_Downshift_Count "
  //"-v 184,raw48,End-to-End_Error "
  //"-v 187,raw48,Reported_Uncorrect "
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic " // Timed Workload Media Wear Indicator (percent*1024)
    "-v 227,raw48,Workld_Host_Reads_Perc "  // Timed Workload Host Reads Percentage
    "-v 228,raw48,Workload_Minutes " // 226,227,228 can be reset by 'smartctl -t vendor,0x40'
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator "
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB"
  },
  { "Intel 320 Series SSDs", // tested with INTEL SSDSA2CT040G3/4PC10362,
      // INTEL SSDSA2CW160G3/4PC10362, SSDSA2BT040G3/4PC10362, SSDSA2BW120G3A/4PC10362,
      // INTEL SSDSA2BW300G3D/4PC10362, SSDSA2BW160G3L/4PC1LE04, SSDSA1NW160G3/4PC10362
    "INTEL SSDSA[12][BCN][WT](040|080|120|160|300|600)G3[ADL]?",
      // 2B = 2.5" 7mm, 2C = 2.5" 9.5mm, 1N = 1.8" microSATA
    "", "",
    "-F nologdir "
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 4,raw48,Start_Stop_Count "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Reserve_Block_Count "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 183,raw48,SATA_Downshift_Count " // FW >= 4Px10362
  //"-v 184,raw48,End-to-End_Error "
  //"-v 187,raw48,Reported_Uncorrect "
    "-v 199,raw48,CRC_Error_Count "      // FW >= 4Px10362
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic " // Timed Workload Media Wear Indicator (percent*1024)
    "-v 227,raw48,Workld_Host_Reads_Perc "  // Timed Workload Host Reads Percentage
    "-v 228,raw48,Workload_Minutes " // 226,227,228 can be reset by 'smartctl -t vendor,0x40'
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator "
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB"
  },
  { "Intel 710 Series SSDs", // tested with INTEL SSDSA2BZ[12]00G3/6PB10362
    "INTEL SSDSA2BZ(100|200|300)G3",
    "", "",
    "-F nologdir "
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 4,raw48,Start_Stop_Count "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Reserve_Block_Count "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct " // Missing in 710 specification from September 2011
    "-v 183,raw48,SATA_Downshift_Count "
  //"-v 184,raw48,End-to-End_Error "
  //"-v 187,raw48,Reported_Uncorrect "
  //"-v 190,tempminmax,Airflow_Temperature_Cel "
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic " // Timed Workload Media Wear Indicator (percent*1024)
    "-v 227,raw48,Workld_Host_Reads_Perc "  // Timed Workload Host Reads Percentage
    "-v 228,raw48,Workload_Minutes " // 226,227,228 can be reset by 'smartctl -t vendor,0x40'
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator "
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB"
  },
  { "Intel 510 Series SSDs",
    "INTEL SSDSC2MH(120|250)A2",
    "", "",
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 4,raw48,Start_Stop_Count "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 225,raw48,Host_Writes_32MiB "
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator"
  },
  { "Intel 520 Series SSDs", // tested with INTEL SSDSC2CW120A3/400i, SSDSC2BW480A3F/400i,
      // INTEL SSDSC2BW180A3L/LB3i
    "INTEL SSDSC2[BC]W(060|120|180|240|480)A3[FL]?",
    "", "",
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
    "-v 9,msec24hour32,Power_On_Hours_and_Msec "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Available_Reservd_Space "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
  //"-v 184,raw48,End-to-End_Error "
    "-v 187,raw48,Uncorrectable_Error_Cnt "
  //"-v 192,raw48,Power-Off_Retract_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic "
    "-v 227,raw48,Workld_Host_Reads_Perc "
    "-v 228,raw48,Workload_Minutes "
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator "
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB "
    "-v 249,raw48,NAND_Writes_1GiB"
  },
  { "Intel 525 Series SSDs", // mSATA, tested with SSDMCEAC120B3/LLLi
    "INTEL SSDMCEAC(030|060|090|120|180|240)B3",
    "", "",
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
    "-v 9,msec24hour32,Power_On_Hours_and_Msec "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Available_Reservd_Space "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 183,raw48,SATA_Downshift_Count "
  //"-v 184,raw48,End-to-End_Error "
    "-v 187,raw48,Uncorrectable_Error_Cnt "
  //"-v 190,tempminmax,Airflow_Temperature_Cel "
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic "
    "-v 227,raw48,Workld_Host_Reads_Perc "
    "-v 228,raw48,Workload_Minutes "
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator "
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB "
    "-v 249,raw48,NAND_Writes_1GiB"
  },
  { "Intel 53x and Pro 2500 Series SSDs", // SandForce SF-2281, tested with
      // INTEL SSDSC2BW180A4/DC12, SSDSC2BW240A4/DC12, SSDMCEAW120A4/DC33
      // INTEL SSDMCEAW240A4/DC33, SSDSC2BF480A5/TG26, SSDSC2BW240H6/RG21
    "INTEL SSD(MCEA|SC2B|SCKJ)[WF](056|080|120|180|240|360|480)(A4|A5|H6)",
      // SC2B = 2.5", MCEA = mSATA, SCKJ = M.2; A4 = 530, A5 = Pro 2500, H6 = 535
    "", "",
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
    "-v 9,msec24hour32,Power_On_Hours_and_Msec "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Available_Reservd_Space "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 183,raw48,SATA_Downshift_Count "
  //"-v 184,raw48,End-to-End_Error "
    "-v 187,raw48,Uncorrectable_Error_Cnt "
  //"-v 190,tempminmax,Airflow_Temperature_Cel "
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic "
    "-v 227,raw48,Workld_Host_Reads_Perc "
    "-v 228,raw48,Workload_Minutes "
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator "
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB "
    "-v 249,raw48,NAND_Writes_1GiB"
  },
  { "Intel 330/335 Series SSDs", // tested with INTEL SSDSC2CT180A3/300i, SSDSC2CT240A3/300i,
      // INTEL SSDSC2CT240A4/335t
    "INTEL SSDSC2CT(060|120|180|240)A[34]", // A4 = 335 Series
    "", "",
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
    "-v 9,msec24hour32,Power_On_Hours_and_Msec "
  //"-v 12,raw48,Power_Cycle_Count "
  //"-v 181,raw48,Program_Fail_Cnt_Total " // ] Missing in 330 specification from April 2012
  //"-v 182,raw48,Erase_Fail_Count_Total " // ]
  //"-v 192,raw48,Power-Off_Retract_Count "
    "-v 225,raw48,Host_Writes_32MiB "
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator "
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB "
    "-v 249,raw48,NAND_Writes_1GiB"
  },
  // https://www.intel.com/content/www/us/en/solid-state-drives/ssd-540s-series-spec.html
  // https://www.intel.com/content/www/us/en/solid-state-drives/ssd-540s-series-m2-spec.html
  { "Intel 540 Series SSDs", // INTEL SSDSC2KW120H6/LSF036C, INTEL SSDSC2KW480H6/LSF036C
    "INTEL SSDSC[K2]KW(120H|180H|240H|360H|480H|010X)6", 
    "", "",
    "-v 9,msec24hour32,Power_On_Hours_and_Msec "
    "-v 170,raw48,Available_Reservd_Space "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 183,raw48,SATA_Downshift_Count "
    "-v 187,raw48,Uncorrectable_Error_Cnt "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic "
    "-v 227,raw48,Workld_Host_Reads_Perc "
    "-v 228,raw48,Workload_Minutes "
    "-v 249,raw48,NAND_Writes_1GiB"
  },
  { "Intel 730 and DC S35x0/3610/3700 Series SSDs", // tested with INTEL SSDSC2BP480G4, SSDSC2BB120G4/D2010355,
      // INTEL SSDSC2BB800G4T, SSDSC2BA200G3/5DV10250, SSDSC2BB080G6/G2010130,  SSDSC2BX200G4/G2010110,
      // INTEL SSDSC2BB016T6/G2010140, SSDSC2BX016T4/G2010140, SSDSC2BB150G7/N2010101
    "INTEL SSDSC(1N|2B)[ABPX]((080|100|120|150|160|200|240|300|400|480|600|800)G[3467]T?|(012|016)T[46])",
      // A = S3700, B*4 = S3500, B*6 = S3510, P = 730, X = S3610
    "", "",
  //"-v 3,raw16(avg16),Spin_Up_Time "
  //"-v 4,raw48,Start_Stop_Count "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Available_Reservd_Space "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 174,raw48,Unsafe_Shutdown_Count "
    "-v 175,raw16(raw16),Power_Loss_Cap_Test "
    "-v 183,raw48,SATA_Downshift_Count "
  //"-v 184,raw48,End-to-End_Error "
  //"-v 187,raw48,Reported_Uncorrect "
    "-v 190,tempminmax,Temperature_Case "
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 194,tempminmax,Temperature_Internal "
  //"-v 197,raw48,Current_Pending_Sector "
    "-v 199,raw48,CRC_Error_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic " // Timed Workload Media Wear Indicator (percent*1024)
    "-v 227,raw48,Workld_Host_Reads_Perc "  // Timed Workload Host Reads Percentage
    "-v 228,raw48,Workload_Minutes " // 226,227,228 can be reset by 'smartctl -t vendor,0x40'
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator "
    "-v 234,raw24/raw32:04321,Thermal_Throttle "
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB "
    "-v 243,raw48,NAND_Writes_32MiB " // S3510/3610
    "-F xerrorlba" // tested with SSDSC2BB600G4/D2010355
  },
  { "Intel 3710 Series SSDs", // INTEL SSDSC2BA200G4R/G201DL2B (dell)
    "INTEL SSDSC2BA(200G|400G|800G|012T)4.?",
    "", "",
    "-v 9,msec24hour32,Power_On_Hours_and_Msec "
    "-v 170,raw48,Available_Reservd_Space "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 183,raw48,SATA_Downshift_Count "
    "-v 187,raw48,Uncorrectable_Error_Cnt "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic "
    "-v 227,raw48,Workld_Host_Reads_Perc "
    "-v 228,raw48,Workload_Minutes "
    "-v 234,raw24/raw32:04321,Thermal_Throttle "
    "-v 243,raw48,NAND_Writes_32MiB "
  },
  { "Kingston branded X25-V SSDs", // fixed firmware
    "KINGSTON SSDNow 40GB",
    "2CV102(J[89A-Z]|[K-Z].)", // >= "2CV102J8"
    "",
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic "
    "-v 227,raw48,Workld_Host_Reads_Perc "
    "-v 228,raw48,Workload_Minutes"
  },
  { "Kingston branded X25-V SSDs", // buggy or unknown firmware
    "KINGSTON SSDNow 40GB",
    "",
    "This drive may require a firmware update to\n"
    "fix possible drive hangs when reading SMART self-test log.\n"
    "To update Kingston branded drives, a modified Intel update\n"
    "tool must be used. Search for \"kingston 40gb firmware\".",
    "-v 192,raw48,Unsafe_Shutdown_Count "
    "-v 225,raw48,Host_Writes_32MiB "
    "-v 226,raw48,Workld_Media_Wear_Indic "
    "-v 227,raw48,Workld_Host_Reads_Perc "
    "-v 228,raw48,Workload_Minutes"
  },
  { "JMicron based SSDs", // JMicron JMF60x
    "Kingston SSDNow V Series [0-9]*GB|" // tested with Kingston SSDNow V Series 64GB/B090522a
    "TS(2|4|8|16|32|64|128|192)GSSD(18|25)[MS]?-[MS]", // Transcend IDE and SATA, tested with
      // TS32GSSD25-M/V090331, TS32GSSD18M-M/v090331
    "[BVv].*", // other Transcend SSD versions will be catched by subsequent entry
    "",
  //"-v 9,raw24(raw8),Power_On_Hours " // raw value always 0?
  //"-v 12,raw48,Power_Cycle_Count "
  //"-v 194,tempminmax,Temperature_Celsius " // raw value always 0?
    "-v 229,hex64:w012345r,Halt_System/Flash_ID " // Halt, Flash[7]
    "-v 232,hex64:w012345r,Firmware_Version_Info " // "YYMMDD", #Channels, #Banks
    "-v 233,hex48:w01234,ECC_Fail_Record " // Fail number, Row[3], Channel, Bank
    "-v 234,raw24/raw24:w01234,Avg/Max_Erase_Count "
    "-v 235,raw24/raw24:w01z23,Good/Sys_Block_Count"
  },
  { "JMicron based SSDs", // JMicron JMF61x, JMF66x, JMF670
    "ADATA S596 Turbo|"  // tested with ADATA S596 Turbo 256GB SATA SSD (JMicron JMF616)
    "ADATA SP600|"  // tested with ADATA SP600/2.4 (JMicron JMF661)
    "ADATA SP310|"  // Premier Pro SP310 mSATA, JMF667, tested with ADATA SP310/3.04
    "APPLE SSD TS(064|128|256|512)C|"  // Toshiba?, tested with APPLE SSD TS064C/CJAA0201
    "KINGSTON SNV425S2(64|128)GB|"  // SSDNow V Series (2. Generation, JMF618),
                                    // tested with KINGSTON SNV425S264GB/C091126a
    "KINGSTON SSDNOW 30GB|" // tested with KINGSTON SSDNOW 30GB/AJXA0202
    "KINGSTON SS100S2(8|16)G|"  // SSDNow S100 Series, tested with KINGSTON SS100S28G/D100309a
    "KINGSTON SNVP325S2(64|128|256|512)GB|" // SSDNow V+ Series, tested with KINGSTON SNVP325S2128GB/AGYA0201
    "KINGSTON SVP?100S2B?(64|96|128|256|512)G|"  // SSDNow V100/V+100 Series,
      // tested with KINGSTON SVP100S296G/CJR10202, KINGSTON SV100S2256G/D110225a
    "KINGSTON SV200S3(64|128|256)G|" // SSDNow V200 Series, tested with KINGSTON SV200S3128G/E120506a
    "TOSHIBA THNS128GG4BBAA|"  // Toshiba / Super Talent UltraDrive DX,
                               // tested with Toshiba 128GB 2.5" SSD (built in MacBooks)
    "TOSHIBA THNSNC128GMLJ|" // tested with THNSNC128GMLJ/CJTA0202 (built in Toshiba Protege/Dynabook)
    "TS(8|16|32|64|128|192|256|512)GSSD25S?-(MD?|S)|" // Transcend IDE and SATA, JMF612, tested with
      // TS256GSSD25S-M/101028, TS32GSSD25-M/20101227
    "TS(32|64|128|256)G(SSD|MSA)340", // Transcend SSD340 SATA/mSATA, JMF667/670, tested with
      // TS256GSSD340/SVN263, TS256GSSD340/SVN423b, TS256GMSA340/SVN263
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 2,raw48,Throughput_Performance "
    "-v 3,raw48,Unknown_JMF_Attribute "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
    "-v 7,raw48,Unknown_JMF_Attribute "
    "-v 8,raw48,Unknown_JMF_Attribute "
  //"-v 9,raw24(raw8),Power_On_Hours "
    "-v 10,raw48,Unknown_JMF_Attribute "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 167,raw48,Unknown_JMF_Attribute "
    "-v 168,raw48,SATA_Phy_Error_Count "
    "-v 169,raw48,Unknown_JMF_Attribute "
    "-v 170,raw16,Bad_Block_Count "
    "-v 173,raw16,Erase_Count " // JMF661: different?
    "-v 175,raw48,Bad_Cluster_Table_Count "
    "-v 192,raw48,Unexpect_Power_Loss_Ct "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 197,raw48,Current_Pending_Sector "
    "-v 233,raw48,Unknown_JMF_Attribute " // FW SVN423b
    "-v 234,raw48,Unknown_JMF_Attribute " // FW SVN423b
    "-v 240,raw48,Unknown_JMF_Attribute "
  //"-v 241,raw48,Total_LBAs_Written "    // FW SVN423b
  //"-v 242,raw48,Total_LBAs_Read "       // FW SVN423b
  },
  { "Plextor M3/M5/M6 Series SSDs", // Marvell 88SS9174 (M3, M5S), 88SS9187 (M5P, M5Pro), 88SS9188 (M6M/S),
      // tested with PLEXTOR PX-128M3/1.01, PX-128M3P/1.04, PX-256M3/1.05, PX-128M5S/1.02, PX-256M5S/1.03,
      // PX-128M5M/1.05, PX-128M5S/1.05, PX-128M5Pro/1.05, PX-512M5Pro/1.06, PX-256M5P/1.01, PX-128M6S/1.03
      // (1.04/5 Firmware self-test log lifetime unit is bogus, possibly 1/256 hours)
    "PLEXTOR PX-(64|128|256|512|768)M(3P?|5[MPS]|5Pro|6[MS])",
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Unknown_Plextor_Attrib "  // M6S/1.03
    "-v 171,raw48,Unknown_Plextor_Attrib "  // M6S/1.03
    "-v 172,raw48,Unknown_Plextor_Attrib "  // M6S/1.03
    "-v 173,raw48,Unknown_Plextor_Attrib "  // M6S/1.03
    "-v 174,raw48,Unknown_Plextor_Attrib "  // M6S/1.03
  //"-v 175,raw48,Program_Fail_Count_Chip " // M6S/1.03
  //"-v 176,raw48,Erase_Fail_Count_Chip "   // M6S/1.03
  //"-v 177,raw48,Wear_Leveling_Count "
  //"-v 178,raw48,Used_Rsvd_Blk_Cnt_Chip "
  //"-v 179,raw48,Used_Rsvd_Blk_Cnt_Tot "   // M6S/1.03
  //"-v 180,raw48,Unused_Rsvd_Blk_Cnt_Tot " // M6S/1.03
  //"-v 181,raw48,Program_Fail_Cnt_Total "
  //"-v 182,raw48,Erase_Fail_Count_Total "
  //"-v 183,raw48,Runtime_Bad_Block "       // M6S/1.03
  //"-v 184,raw48,End-to-End_Error "        // M6S/1.03
  //"-v 187,raw48,Reported_Uncorrect "
  //"-v 188,raw48,Command_Timeout "         // M6S/1.03
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 195,raw48,Hardware_ECC_Recovered "  // MS6/1.03
  //"-v 196,raw16(raw16),Reallocated_Event_Count "
  //"-v 198,raw48,Offline_Uncorrectable "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
  //"-v 232,raw48,Available_Reservd_Space "
  //"-v 233,raw48,Media_Wearout_Indicator " // MS6/1.03
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB"
  },
  { "Samsung based SSDs",
    "SAMSUNG SSD PM800 .*GB|"  // SAMSUNG PM800 SSDs, tested with SAMSUNG SSD PM800 TH 64GB/VBM25D1Q
    "SAMSUNG SSD PM810 .*GB|"  // SAMSUNG PM810 (470 series) SSDs, tested with SAMSUNG SSD PM810 2.5" 128GB/AXM06D1Q
    "SAMSUNG SSD PM851 (mSATA |M\\.2 )?(2280 )?(128|256|512)GB|" // tested with SAMSUNG SSD PM851 mSATA 128GB,
      // SAMSUNG SSD PM851 M.2 2280 256GB/EXT25D0Q
    "SAMSUNG SSD SM841N (mSATA )?(128|256|512)GB|" // tested with SAMSUNG SSD SM841N mSATA 256GB
    "SAMSUNG 470 Series SSD|"  // tested with SAMSUNG 470 Series SSD 64GB/AXM09B1Q
    "Samsung SSD 750 EVO (120|250|500)GB|" // tested with Samsung SSD 750 EVO 250GB/MAT01B6Q
    "SAMSUNG SSD 830 Series|"  // tested with SAMSUNG SSD 830 Series 64GB/CXM03B1Q
    "SAMSUNG SSD PM830 .*|" // SAMSUNG SSD PM830 2.5" 7mm 128GB/CXM03D1Q
    "MZ7PC(512|256|128|064)HA(GH|FU|DR)-000.*|" // probably PM830, tested with SAMSUNG MZ7PC128HAFU-000L1/CXM04L1Q
    "Samsung SSD 840 (PRO )?Series|" // tested with Samsung SSD 840 PRO Series 128GB/DXM04B0Q,
      // Samsung SSD 840 Series/DXT06B0Q
    "Samsung SSD 8[45]0 EVO .*|" // tested with
      // Samsung SSD 840 EVO (120|250|500|750)GB/EXT0AB0Q,
      // Samsung SSD 840 EVO (120|250)GB/EXT0BB6Q, 1TB/EXT0BB0Q, 120GB mSATA/EXT41B6Q,
      // Samsung SSD 850 EVO 250GB/EMT01B6Q
      // Samsung SSD 850 EVO M.2 250GB/EMT21B6Q
      // Samsung SSD 850 EVO mSATA 120GB/EMT41B6Q
      // Samsung SSD 850 EVO 2TB/EMT02B6Q
    "Samsung SSD 850 PRO ((128|256|512)G|1T)B|" // tested with Samsung SSD 850 PRO 128GB/EXM01B6Q,
      // Samsung SSD 850 PRO 1TB/EXM01B6Q
    "SAMSUNG MZ7PA256HMDR-.*|" // PM810 (470 Series), tested with SAMSUNG MZ7PA256HMDR-010H1/AXM07H1Q
    "Samsung SSD 845DC EVO .*|" // Samsung SSD 845DC EVO 960GB/EXT03X3Q
    "SAMSUNG MZ[7M]PC(032|064|128|256|512)HBCD-.*|" // PM830, tested with SAMSUNG MZMPC032HBCD-000L1/CXM12L1Q
    "SAMSUNG MZ7TD(128|256)HAFV-.*|" // 840 Series, tested with SAMSUNG MZ7TD256HAFV-000L7/DXT06L6Q
    "SAMSUNG MZ7WD((120|240)H[AC]FV|480HAGM|960HAGP)-00003|" // SM843T Series, tested with
      // SAMSUNG MZ7WD120HAFV-00003/DXM85W3Q, SAMSUNG MZ7WD120HCFV-00003/DXM9203Q
    "SAMSUNG MZ[7N]TE(128|256|512)HMHP-.*|" // PM851, tested with SAMSUNG MZ7TE256HMHP-000L7/EXT09L6Q,
      // SAMSUNG MZNTE256HMHP-000H1/EXT22H0Q
    "SAMSUNG MZ7GE(240HMGR|(480|960)HMHP)-00003|" // SM853T Series, tested with
      // SAMSUNG MZ7GE240HMGR-00003/EXT0303Q
    "SAMSUNG MZ7LM(120|240|480|960|1T9|3T8)HC(JM|HP|GR|FD)-.*|" // PM863 Series, tested with
      // SAMSUNG MZ7LM960HCHP-0E003/GXT3003Q
    "SAMSUNG MZ7KM(120|240|480|960|1T9)HA(JM|HP|GR|FD|JM)-.*|" // SM863, tested with MZ7KM480HAHP-0E005/GXM1003Q
    "SAMSUNG MZN(LF|TY)(128|256)H[CD]HP-.*|" // CM871/871a, tested with SAMSUNG MZNLF128HCHP-000H1/FXT21H1Q,
      // SAMSUNG MZNTY256HDHP-000/MAT21K0Q
    "SAMSUNG MZ[7N]LN(128|256|512|1T0)H[ACM](GR|HP|HQ|J[HPQ]|LR)-.*|" // PM871/871a/b, tested with
      // SAMSUNG MZ7LN128HCHP-00000/EMT0100Q, SAMSUNG MZ7LN256HAHQ-000H1/MVT03H6Q,
      // SAMSUNG MZNLN256HMHQ-000H1/MAV21H3Q
    "SAMSUNG SSD PM871 .*|" // SAMSUNG SSD PM871 2.5 7mm 256GB/EMT02D0Q
      // SAMSUNG MZ7LN256HMJP-00000/MAV0100Q, SAMSUNG MZ7LN512HMJP-00000/MAV0100Q
    "SAMSUNG MZHPV(128|256|512)HDGL-.*", // SM951, tested with SAMSUNG MZHPV512HDGL-00000/BXW2500Q
    "", "",
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 170,raw48,Unused_Rsvd_Blk_Ct_Chip " // CM871
    "-v 171,raw48,Program_Fail_Count_Chip " // CM871
    "-v 172,raw48,Erase_Fail_Count_Chip " // CM871
    "-v 173,raw48,Wear_Leveling_Count " // CM871
    "-v 174,raw48,Unexpect_Power_Loss_Ct " // CM871
  //"-v 175,raw48,Program_Fail_Count_Chip "
  //"-v 176,raw48,Erase_Fail_Count_Chip "
  //"-v 177,raw48,Wear_Leveling_Count "
  //"-v 178,raw48,Used_Rsvd_Blk_Cnt_Chip "
  //"-v 179,raw48,Used_Rsvd_Blk_Cnt_Tot "
  //"-v 180,raw48,Unused_Rsvd_Blk_Cnt_Tot "
  //"-v 181,raw48,Program_Fail_Cnt_Total "
  //"-v 182,raw48,Erase_Fail_Count_Total "
  //"-v 183,raw48,Runtime_Bad_Block "
  //"-v 184,raw48,End-to-End_Error " // SM843T Series
    "-v 187,raw48,Uncorrectable_Error_Cnt "
  //"-v 190,tempminmax,Airflow_Temperature_Cel "  // seems to be some sort of temperature value for 470 Series?
    "-v 191,raw48,Unknown_Samsung_Attr " // PM810
  //"-v 194,tempminmax,Temperature_Celsius "
    "-v 195,raw48,ECC_Error_Rate "
  //"-v 196,raw16(raw16),Reallocated_Event_Count "
  //"-v 198,raw48,Offline_Uncorrectable "
    "-v 199,raw48,CRC_Error_Count "
    "-v 201,raw48,Supercap_Status "
    "-v 202,raw48,Exception_Mode_Status "
  //"-v 233,raw48,Media_Wearout_Indicator // PM851, 840
    "-v 234,raw48,Unknown_Samsung_Attr " // PM851, 840
    "-v 235,raw48,POR_Recovery_Count " // PM851, 830/840/850
    "-v 236,raw48,Unknown_Samsung_Attr " // PM851, 840
    "-v 237,raw48,Unknown_Samsung_Attr " // PM851, 840
    "-v 238,raw48,Unknown_Samsung_Attr " // PM851, 840
  //"-v 241,raw48,Total_LBAs_Written "
  //"-v 242,raw48,Total_LBAs_Read " // PM851, SM841N
    "-v 243,raw48,SATA_Downshift_Ct " // PM863
    "-v 244,raw48,Thermal_Throttle_St " // PM863
    "-v 245,raw48,Timed_Workld_Media_Wear " // PM863
    "-v 246,raw48,Timed_Workld_RdWr_Ratio " // PM863
    "-v 247,raw48,Timed_Workld_Timer " // PM863
    "-v 249,raw48,Unknown_Samsung_Attr " // CM871a
    "-v 250,raw48,SATA_Iface_Downshift " // from the spec
    "-v 251,raw48,NAND_Writes" // PM863
  },
  { "Marvell based SanDisk SSDs",
    "SanDisk SD5SG2[0-9]*G1052E|" // X100 (88SS9174), tested with SanDisk SD5SG2256G1052E/10.04.01
    "SanDisk SD6S[BF][12]M[0-9]*G(1022I?)?|" // X110/X210 (88SS9175/187?), tested with SanDisk SD6SB1M064G1022I/X231600,
      // SanDisk SD6SB1M256G1022I/X231600, SanDisk SD6SF1M128G1022/X231200, SanDisk SD6SB2M512G1022I/X210400
    "SanDisk SD7S[BN]6S-?(128|256|512)G(1122|-1006)|" // X300 (88SS9189?), tested with
      // SanDisk SD7SB6S128G1122/X3310000, SanDisk SD7SN6S-512G-1006/X3511006
    "SanDisk SD8SB8U((128|256|512)G|1T00)1122|" // X400 (88SS1074), tested with SanDisk SD8SB8U128G1122/X4120000
    "SanDisk SDSSDHP[0-9]*G|" // Ultra Plus (88SS9175), tested with SanDisk SDSSDHP128G/X23[01]6RL
    "SanDisk (SDSSDHII|Ultra II )[0-9]*GB?|" // Ultra II (88SS9190/88SS9189), tested with
      // SanDisk SDSSDHII120G/X31200RL, SanDisk Ultra II 960GB/X41100RL
    "SanDisk SDSSDXPS?[0-9]*G", // Extreme II/Pro (88SS9187), tested with SanDisk SDSSDXP480G/R1311,
      // SanDisk SDSSDXPS480G/X21200RL
    "", "",
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 165,raw48,Total_Write/Erase_Count "
    "-v 166,raw48,Min_W/E_Cycle "
    "-v 167,raw48,Min_Bad_Block/Die "
    "-v 168,raw48,Maximum_Erase_Cycle "
    "-v 169,raw48,Total_Bad_Block "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Avg_Write/Erase_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
  //"-v 184,raw48,End-to-End_Error "
  //"-v 187,raw48,Reported_Uncorrect "
  //"-v 188,raw48,Command_Timeout "
  //"-v 194,tempminmax,Temperature_Celsius "
    "-v 199,raw48,SATA_CRC_Error "
    "-v 212,raw48,SATA_PHY_Error "
    "-v 230,raw48,Perc_Write/Erase_Count "
    "-v 232,raw48,Perc_Avail_Resrvd_Space "
    "-v 233,raw48,Total_NAND_Writes_GiB "
    "-v 234,raw48,Perc_Write/Erase_Ct_BC "
    "-v 241,raw48,Total_Writes_GiB "
    "-v 242,raw48,Total_Reads_GiB "
  //"-v 243,raw48,Unknown_Attribute "
    "-v 244,raw48,Thermal_Throttle "
  },
  { "SanDisk based SSDs", // see also #463 for the vendor attribute description
    "SanDisk iSSD P4 [0-9]*GB|" // tested with SanDisk iSSD P4 16GB/SSD 9.14
    "SanDisk pSSD|" // tested with SandDisk pSSD/3 (62.7 GB, SanDisk Extreme USB3.0 SDCZ80-064G-J57, 0x0781:0x5580)
    "SanDisk SDSSDP[0-9]*G|" // tested with SanDisk SDSSDP064G/1.0.0, SDSSDP128G/2.0.0
    "SanDisk SDSSDRC032G|" // tested with SanDisk SanDisk SDSSDRC032G/3.1.0
    "SanDisk SSD i100 [0-9]*GB|" // tested with SanDisk SSD i100 8GB/11.56.04, 24GB/11.56.04
    "SanDisk SSD U100 ([0-9]*GB|SMG2)|" // tested with SanDisk SSD U100 8GB/10.56.00, 256GB/10.01.02, SMG2/10.56.04
    "SanDisk SSD U110 (8|16|24|32|64|128)GB|" // tested with SanDisk SSD U110 32GB/U221000
    "SanDisk SD7[SU]B[23]Q(064|128|256|512)G.*", // tested with SD7SB3Q064G1122/SD7UB3Q256G1122/SD7SB3Q128G/SD7UB2Q512G1122
    "", "",
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 165,raw48,Total_Write/Erase_Count "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Avg_Write/Erase_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
  //"-v 187,raw48,Reported_Uncorrect "
    "-v 212,raw48,SATA_PHY_Error "
    "-v 230,raw48,Perc_Write/Erase_Count "
    "-v 232,raw48,Perc_Avail_Resrvd_Space "
    "-v 234,raw48,Perc_Write/Erase_Ct_BC "
  //"-v 241,raw48,Total_LBAs_Written "
  //"-v 242,raw48,Total_LBAs_Read "
    "-v 244,raw48,Thermal_Throttle "
  },
  //  SDLF1DAR-480G-1HAW/ZR07RE41
  // SDLF1DAR-480G-1JA1/RP41ZH06
  { "Sandisk SATA Cloudspeed Max and GEN2 ESS SSDs",
   "SD[A-Z0-9]{2}[1-3][A-Z]{3}-?[0-9]{3}[GT]-?1[A-Z0-9]{3}",
   "","",
   "-v 13,raw48,Lifetime_UECC_Ct "
   "-v 32,raw48,Lifetime_Write_AmpFctr "
   "-v 33,raw48,Write_AmpFctr "
   "-v 170,raw48,Reserve_Erase_BlkCt "
   "-v 171,raw48,Program_Fail_Ct "
   "-v 172,raw48,Erase_Fail_Ct "
   "-v 173,raw48,Percent_Life_Used "
   "-v 174,raw48,Unexpect_Power_Loss "
   "-v 175,raw48,Lifetime_Die_Failure_Ct "
   "-v 177,raw48,Lifetime_Remaining% "
   "-v 178,raw48,SSD_LifeLeft(0.01%) "
   "-v 180,raw48,Undetected_Data_Err_Ct "
   "-v 183,raw48,LT_Link_Rate_DwnGrd_Ct "
   "-v 191,raw48,Clean_Shutdown_Ct "
   "-v 192,raw48,Unclean_Shutdown_Ct "
   "-v 196,raw48,Lifetime_Retried_Blk_Ct "
   "-v 204,raw48,Average_Block-Erase_Ct "
   "-v 205,raw48,Read_Retry_Enable_Ct "
   "-v 206,raw48,Successful_RaidRecov_Ct "
   "-v 207,raw48,Trimmed_Sector_Ct "
   "-v 211,raw48,Read_Disturb_ReallocEvt "
   "-v 233,raw48,Lifetime_Nand_Writes "
   "-v 235,raw48,Capacitor_Health "
   "-v 244,raw48,Therm_Throt_Activation "
   "-v 245,raw48,Drive_Life_Remaining% "
   "-v 253,raw48,SPI_Test_Remaining "
 },
 { "Sandisk SATA CS1K GEN1 ESS SSDs",
   "SD[A-Z0-9]{2}[NO][A-Z0-9]{3}-?[0-9]{3}[GT]-?1[A-Z0-9]{3}",
   "","",
   "-v 1,raw48,UECC_Ct "
   "-v 2,raw48,Internal_File_Check "
   "-v 5,raw16(raw16),Retried_Blk_Ct "
   "-v 32,raw48,Write_Ampflication "
   "-v 170,raw48,Reserve_Blk_Remaining "
   "-v 171,raw48,Program_Fail_Ct "
   "-v 172,raw48,Erase_Fail_Ct "
   "-v 173,raw48,Drive_Life_Used% "
   "-v 174,raw48,Unexpect_PwrLoss_Ct "
   "-v 175,raw48,PwrLoss_ProtectionFail "
   "-v 177,raw48,DriveLife_Remaining% "
   "-v 178,raw48,SSD_Life_Left "
   "-v 180,raw48,End_to_End_Err_Detect "
   "-v 190,raw48,Drive_Temp_Warning "
   "-v 195,raw48,Uncorrectable_Err_Ct "
   "-v 202,raw48,Exception_Mode_Status "
   "-v 233,raw48,Number_Of_Write_Ct "
   "-v 245,raw48,DriveLife_Used% "
 },
  { "SiliconMotion based SSDs", // SM2246EN (Transcend TS6500)
    "R3SL(120|240|480|960)G|" // AMD Radeon Solid State Drives,
    "CT(120|250|500|1000)BX100SSD1|" // Crucial BX100, tested with CT250BX100SSD1/MU02,
      // CT500BX100SSD1/MU02, CT1000BX100SSD1/MU02
    "CT(240|480|960)BX200SSD1|" // Crucial BX200 Solid State Drive, tested with CT480BX200SSD1/MU02.6
    "TS((16|32|64|128|256|512)G|1T)(SSD|MSA)(370S?|420I?)|" // Transcend SSD370/420 SATA/mSATA, TS6500,
      // tested with TS32GMSA370/20140402, TS16GMSA370/20140516, TS64GSSD370/20140516,
      // TS256GSSD370/N0815B, TS256GSSD370S/N1114H, TS512GSSD370S/N1114H, TS32GSSD420I/N1114H
      // TS256GMTS400
    "TS(16|32|64|128|512|256)GMTS400S?|"
    "TS(120|240)GMTS420|" // Transcend MTS420, TS(120|240)GMTS420
    "TS(128G|256G|512G|1T)SSD230S|" // TS128GSSD230S/P1025F8
    "TS(120|240|480|960)GSSD220S|" // TS480GSSD220S/P0520AA
    "TS(16G|32G|64G|128G|256G|512G|1T)MTS800S?|" // MTS800, tested with TS1TMTS800/O1225H1
    "TS(16|32|64)GMSA630|" // MSA630 mSATA SSD, tested with TS32GMSA630/N0113E1
    "MKNSSDRE(1TB|2TB|512GB|500GB|256GB|250GB)|" // MKNSSDRE256GB/N1007C
    "MKNSSDTR(240|500|250|120|480|240)GB(-LT)?|" // MKNSSDTR500GB/O1126A
    "LITEON LMH-(128|256|512)V2M-.*|" // LITEON LMH-256V2M-11 MSATA 256GB/FM8110C
    "ADATA SP550", // ADATA SP550/O0803B5a
    "", "",
  //"-v 1,raw48,Raw_Read_Error_Rate "
  //"-v 2,raw48,Throughput_Performance "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 148,raw48,Total_SLC_Erase_Ct "
    "-v 149,raw48,Max_SLC_Erase_Ct "
    "-v 150,raw48,Min_SLC_Erase_Ct "
    "-v 151,raw48,Average_SLC_Erase_Ct "
    "-v 160,raw48,Uncorrectable_Error_Cnt "
    "-v 161,raw48,Valid_Spare_Block_Cnt "
    "-v 163,raw48,Initial_Bad_Block_Count "
    "-v 164,raw48,Total_Erase_Count "
    "-v 165,raw48,Max_Erase_Count "
    "-v 166,raw48,Min_Erase_Count "
    "-v 167,raw48,Average_Erase_Count "
    "-v 168,raw48,Max_Erase_Count_of_Spec "
    "-v 169,raw48,Remaining_Lifetime_Perc "
  //"-v 175,raw48,Program_Fail_Count_Chip "
  //"-v 176,raw48,Erase_Fail_Count_Chip "
  //"-v 177,raw48,Wear_Leveling_Count "
    "-v 178,raw48,Runtime_Invalid_Blk_Cnt "
  //"-v 181,raw48,Program_Fail_Cnt_Total "
  //"-v 182,raw48,Erase_Fail_Count_Total "
  //"-v 187,raw48,Reported_Uncorrect "
  //"-v 192,raw48,Power-Off_Retract_Count "
  //"-v 194,tempminmax,Temperature_Celsius "
  //"-v 195,raw48,Hardware_ECC_Recovered "
  //"-v 196,raw16(raw16),Reallocated_Event_Count "
  //"-v 197,raw48,Current_Pending_Sector "
  //"-v 198,raw48,Offline_Uncorrectable "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
    "-v 225,raw48,Host_Writes_32MiB " // FW 20140402
  //"-v 232,raw48,Available_Reservd_Space "
    "-v 241,raw48,Host_Writes_32MiB "
    "-v 242,raw48,Host_Reads_32MiB "
    "-v 245,raw48,TLC_Writes_32MiB " // FW N0815B, N1114H
    "-v 246,raw48,SLC_Writes_32MiB "
    "-v 247,raw48,Raid_Recoverty_Ct"
  },
  { "SMART Modular Technologies mSATA XL+ SLC SSDs", // tested with SH9MST6D16GJSI01
    "SH9MST6D[0-9]*GJSI?[0-9]*", // based on http://www.smartm.com/salesLiterature/embedded/mSATA_overview.pdf
    "", "", // attributes info from http://www.mouser.com/ds/2/723/smartmodular_09302015_SH9MST6DxxxGJSxxx_rA[1]-770719.pdf
    "-v 1,raw48,Uncorrectable_ECC_Cnt "
  //"-v 5,raw16(raw16),Reallocated_Sector_Ct "
    "-v 9,raw48,Power_On_Hours " // override default raw24(raw8) format
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 14,raw48,Device_Capacity_LBAs "
    "-v 15,raw48,User_Capacity_LBAs " // spec DecID is wrong, HexID is right
    "-v 16,raw48,Init_Spare_Blocks_Avail " // spec DecID is wrong, HexID is right
    "-v 17,raw48,Spare_Blocks_Remaining " // spec DecID is wrong, HexID is right
    "-v 100,raw48,Total_Erase_Count "
    "-v 168,raw48,SATA_PHY_Err_Ct "
    "-v 170,raw48,Initial_Bad_Block_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Max_Erase_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 175,raw48,Average_Erase_Count "
  //"-v 181,raw48,Program_Fail_Cnt_Total "
  //"-v 187,raw48,Reported_Uncorrect "
  //"-v 194,tempminmax,Temperature_Celsius "
    "-v 197,raw48,Not_In_Use "
    "-v 198,raw48,Not_In_Use "
    "-v 199,raw48,SATA_CRC_Error_Count "
    "-v 202,raw48,Perc_Rated_Life_Used "
    "-v 231,raw48,Perc_Rated_Life_Remain "
    "-v 232,raw48,Read_Fail_Count "
    "-v 234,raw48,Flash_Reads_LBAs "
    "-v 235,raw48,Flash_Writes_LBAs "
    "-v 241,raw48,Host_Writes_LBAs "
    "-v 242,raw48,Host_Reads_LBAs"
    //  247-248 Missing in specification from April 2015
  },
  { "Smart Storage Systems Xcel-10 SSDs",  // based on http://www.smartm.com/files/salesLiterature/storage/xcel10.pdf
    "SMART A25FD-(32|64|128)GI32N", // tested with SMART A25FD-128GI32N/B9F23D4K
    "",
    "", // attributes info from http://www.adtron.com/pdf/SMART_Attributes_Xcel-10_810800014_RevB.pdf
    "-v 1,raw48,Not_Supported "
    "-v 2,raw48,Not_Supported "
  //"-v 9,raw24(raw8),Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 191,raw48,Not_Supported "
  //"-v 192,raw48,Power-Off_Retract_Count "
    "-v 197,raw48,ECC_Error_Count "
  //"-v 198,raw48,Offline_Uncorrectable "
  //"-v 199,raw48,UDMA_CRC_Error_Count "
    "-v 251,raw48,Min_Spares_Remain_Perc " // percentage of the total number of spare blocks available
    "-v 252,raw48,Added_Bad_Flash_Blk_Ct " // number of bad flash blocks
    "-v 254,raw48,Total_Erase_Blocks_Ct" // number of times the drive has erased any erase block
  },
  { "Smart Storage Systems XceedSecure2 SSDs",
    "(SMART|Adtron) ([AIS]25FBS|S35FCS).*",
    "", "",
    "-v 9,sec2hour,Power_On_Hours "
    "-v 194,hex64,Proprietary_194"
  },
  { "Smart Storage Systems XceedUltraX/Adtron A25FBX SSDs",
    "(SMART|Adtron) (A|I)25FBX.*",
    "", "",
    "-v 9,hex64,Proprietary_9 "
    "-v 194,hex48,Proprietary_194"
  },
  { "Smart Storage Systems Adtron A25FB 2xN SSDs",
    "(SMART|Adtron) A25FB.*2.N",
    "", "",
    "-v 110,hex64,Proprietary_HWC "
    "-v 111,hex64,Proprietary_MP "
    "-v 112,hex64,Proprietary_RtR "
    "-v 113,hex64,Proprietary_RR "
    "-v 120,hex64,Proprietary_HFAll "
    "-v 121,hex64,Proprietary_HF1st "
    "-v 122,hex64,Proprietary_HF2nd "
    "-v 123,hex64,Proprietary_HF3rd "
    "-v 125,hex64,Proprietary_SFAll "
    "-v 126,hex64,Proprietary_SF1st "
    "-v 127,hex64,Proprietary_SF2nd "
    "-v 128,hex64,Proprietary_SF3rd "
    "-v 194,raw24/raw32:zvzzzw,Fractional_Temperature"
  },
  { "Smart Storage Systems Adtron A25FB 3xN SSDs",
    "(SMART|Adtron) A25FB-.*3.N",
    "", "",
    "-v 9,sec2hour,Power_On_Hours "
    "-v 113,hex48,Proprietary_RR "
    "-v 130,raw48:54321,Minimum_Spares_All_Zs"
  //"-v 194,tempminmax,Temperature_Celsius"
  },
  { "STEC Mach2 CompactFlash Cards", // tested with STEC M2P CF 1.0.0/K1385MS
    "STEC M2P CF 1.0.0",
    "", "",
    "-v 100,raw48,Erase_Program_Cycles "
    "-v 103,raw48,Remaining_Energy_Storg "
    "-v 170,raw48,Reserved_Block_Count "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Wear_Leveling_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 211,raw48,Unknown_Attribute " // ] Missing in specification
    "-v 212,raw48,Unknown_Attribute"  // ] from September 2012
  },
  { "Transcend CompactFlash Cards", // tested with TRANSCEND/20080820,
      // TS4GCF133/20100709, TS16GCF133/20100709, TS16GCF150/20110407
    "TRANSCEND|TS(4|8|16)GCF(133|150)",
    "", "",
    "-v 7,raw48,Unknown_Attribute "
    "-v 8,raw48,Unknown_Attribute"
  },
  { "Marvell SSD SD88SA024BA0 (SUN branded)",
    "MARVELL SD88SA024BA0 SUN24G 0902M0054V",
    "", "", ""
  },
  { "HP 1TB SATA disk GB1000EAFJL",
    "GB1000EAFJL",
    "", "", ""
  },
  { "HP 500GB SATA disk MM0500EANCR",
    "MM0500EANCR",
    "", "", ""
  },
  { "HP 250GB SATA disk VB0250EAVER",
    "VB0250EAVER",
    "", "", ""
  },
  { "IBM Deskstar 60GXP",  // ER60A46A firmware
    "(IBM-|Hitachi )?IC35L0[12346]0AVER07.*",
    "ER60A46A",
    "", ""
  },
  { "IBM Deskstar 60GXP",  // All other firmware
    "(IBM-|Hitachi )?IC35L0[12346]0AVER07.*",
    "",
    "IBM Deskstar 60GXP drives may need upgraded SMART firmware.\n"
    "Please see http://haque.net/dtla_update/",
    ""
  },
  { "IBM Deskstar 40GV & 75GXP (A5AA/A6AA firmware)",
    "(IBM-)?DTLA-30[57]0[123467][05].*",
    "T[WX][123468AG][OF]A[56]AA",
    "", ""
  },
  { "IBM Deskstar 40GV & 75GXP (all other firmware)",
    "(IBM-)?DTLA-30[57]0[123467][05].*",
    "",
    "IBM Deskstar 40GV and 75GXP drives may need upgraded SMART firmware.\n"
    "Please see http://haque.net/dtla_update/",
    ""
  },
  { "", // ExcelStor J240, J340, J360, J680, J880 and J8160
    "ExcelStor Technology J(24|34|36|68|88|816)0",
    "", "", ""
  },
  { "", // Fujitsu M1623TAU
    "FUJITSU M1623TAU",
    "",
    "",
    "-v 9,seconds"
  },
  { "Fujitsu MHG",
    "FUJITSU MHG2...ATU?.*",
    "",
    "",
    "-v 9,seconds"
  },
  { "Fujitsu MHH",
    "FUJITSU MHH2...ATU?.*",
    "",
    "",
    "-v 9,seconds"
  },
  { "Fujitsu MHJ",
    "FUJITSU MHJ2...ATU?.*",
    "",
    "",
    "-v 9,seconds"
  },
  { "Fujitsu MHK",
    "FUJITSU MHK2...ATU?.*",
    "",
    "",
    "-v 9,seconds"
  },
  { "",  // Fujitsu MHL2300AT
    "FUJITSU MHL2300AT",
    "",
    "This drive's firmware has a harmless Drive Identity Structure\n"
      "checksum error bug.",
    "-v 9,seconds"
  },
  { "",  // MHM2200AT, MHM2150AT, MHM2100AT, MHM2060AT
    "FUJITSU MHM2(20|15|10|06)0AT",
    "",
    "This drive's firmware has a harmless Drive Identity Structure\n"
      "checksum error bug.",
    "-v 9,seconds"
  },
  { "Fujitsu MHN",
    "FUJITSU MHN2...AT",
    "",
    "",
    "-v 9,seconds"
  },
  { "", // Fujitsu MHR2020AT
    "FUJITSU MHR2020AT",
    "",
    "",
    "-v 9,seconds"
  },
  { "", // Fujitsu MHR2040AT
    "FUJITSU MHR2040AT",
    "",    // Tested on 40BA
    "",
    "-v 9,seconds -v 192,emergencyretractcyclect "
    "-v 198,offlinescanuncsectorct -v 200,writeerrorcount"
  },
  { "Fujitsu MHS AT",
    "FUJITSU MHS20[6432]0AT(  .)?",
    "",
    "",
    "-v 9,seconds -v 192,emergencyretractcyclect "
    "-v 198,offlinescanuncsectorct -v 200,writeerrorcount "
    "-v 201,detectedtacount"
  },
  { "Fujitsu MHT", // tested with FUJITSU MHT2030AC/909B
    "FUJITSU MHT2...(AC|AH|AS|AT|BH)U?.*",
    "",
    "",
    "-v 9,seconds"
  },
  { "Fujitsu MHU",
    "FUJITSU MHU2...ATU?.*",
    "",
    "",
    "-v 9,seconds"
  },
  { "Fujitsu MHV",
    "FUJITSU MHV2...(AH|AS|AT|BH|BS|BT).*",
    "",
    "",
    "-v 9,seconds"
  },
  { "Fujitsu MPA..MPG",
    "FUJITSU MP[A-G]3...A[HTEV]U?.*",
    "",
    "",
    "-v 9,seconds"
  },
  { "Fujitsu MHY BH",
    "FUJITSU MHY2(04|06|08|10|12|16|20|25)0BH.*",
    "", "",
    "-v 240,raw48,Transfer_Error_Rate"
  },
  { "Fujitsu MHW AC", // tested with FUJITSU MHW2060AC/00900004
    "FUJITSU MHW20(40|60)AC",
    "", "", ""
  },
  { "Fujitsu MHW BH",
    "FUJITSU MHW2(04|06|08|10|12|16)0BH.*",
    "", "", ""
  },
  { "Fujitsu MHW BJ",
    "FUJITSU MHW2(08|12|16)0BJ.*",
    "", "", ""
  },
  { "Fujitsu MHZ BH",
    "FUJITSU MHZ2(04|08|12|16|20|25|32)0BH.*",
    "", "", ""
  },
  { "Fujitsu MHZ BJ",
    "FUJITSU MHZ2(08|12|16|20|25|32)0BJ.*",
    "",
    "",
    "-v 9,minutes"
  },
  { "Fujitsu MHZ BS",
    "FUJITSU MHZ2(12|25)0BS.*",
    "", "", ""
  },
  { "Fujitsu MHZ BK",
    "FUJITSU MHZ2(08|12|16|25)0BK.*",
    "", "", ""
  },
  { "Fujitsu MJA BH",
    "FUJITSU MJA2(08|12|16|25|32|40|50)0BH.*",
    "", "", ""
  },
  { "", // Samsung SV4012H (known firmware)
    "SAMSUNG SV4012H",
    "RM100-08",
    "",
    "-v 9,halfminutes -F samsung"
  },
  { "", // Samsung SV4012H (all other firmware)
    "SAMSUNG SV4012H",
    "",
    "May need -F samsung disabled; see manual for details.",
    "-v 9,halfminutes -F samsung"
  },
  { "", // Samsung SV0412H (known firmware)
    "SAMSUNG SV0412H",
    "SK100-01",
    "",
    "-v 9,halfminutes -v 194,10xCelsius -F samsung"
  },
  { "", // Samsung SV0412H (all other firmware)
    "SAMSUNG SV0412H",
    "",
    "May need -F samsung disabled; see manual for details.",
    "-v 9,halfminutes -v 194,10xCelsius -F samsung"
  },
  { "", // Samsung SV1204H (known firmware)
    "SAMSUNG SV1204H",
    "RK100-1[3-5]",
    "",
    "-v 9,halfminutes -v 194,10xCelsius -F samsung"
  },
  { "", // Samsung SV1204H (all other firmware)
    "SAMSUNG SV1204H",
    "",
    "May need -F samsung disabled; see manual for details.",
    "-v 9,halfminutes -v 194,10xCelsius -F samsung"
  },
  { "", // SAMSUNG SV0322A tested with FW JK200-35
    "SAMSUNG SV0322A",
    "", "", ""
  },
  { "SAMSUNG SpinPoint V80", // tested with SV1604N/TR100-23
    "SAMSUNG SV(0211|0401|0612|0802|1203|1604)N",
    "",
    "",
    "-v 9,halfminutes -F samsung2"
  },
  { "", // SAMSUNG SP40A2H with RR100-07 firmware
    "SAMSUNG SP40A2H",
    "RR100-07",
    "",
    "-v 9,halfminutes -F samsung"
  },
  { "", // SAMSUNG SP80A4H with RT100-06 firmware
    "SAMSUNG SP80A4H",
    "RT100-06",
    "",
    "-v 9,halfminutes -F samsung"
  },
  { "", // SAMSUNG SP8004H with QW100-61 firmware
    "SAMSUNG SP8004H",
    "QW100-61",
    "",
    "-v 9,halfminutes -F samsung"
  },
  { "SAMSUNG SpinPoint F1 DT", // tested with HD103UJ/1AA01113
    "SAMSUNG HD(083G|16[12]G|25[12]H|32[12]H|50[12]I|642J|75[23]L|10[23]U)J",
    "", "", ""
  },
  { "SAMSUNG SpinPoint F1 EG", // tested with HD103UI/1AA01113
    "SAMSUNG HD(252H|322H|502I|642J|753L|103U)I",
    "", "", ""
  },
  { "SAMSUNG SpinPoint F1 RE", // tested with HE103UJ/1AA01113
    "SAMSUNG HE(252H|322H|502I|642J|753L|103U)J",
    "", "", ""
  },
  { "SAMSUNG SpinPoint F2 EG", // tested with HD154UI/1AG01118
    "SAMSUNG HD(502H|10[23]S|15[34]U)I",
    "", "", ""
  },
  { "SAMSUNG SpinPoint F3", // tested with HD502HJ/1AJ100E4
    "SAMSUNG HD(502H|754J|103S)J",
    "", "", ""
  },
  { "Seagate Barracuda SpinPoint F3", // tested with ST1000DM005 HD103SJ/1AJ100E5
    "ST[0-9DM]* HD(502H|754J|103S)J",
    "", "", ""
  },
  { "SAMSUNG SpinPoint F3 EG", // tested with HD503HI/1AJ100E4, HD153WI/1AN10002
    "SAMSUNG HD(253G|(324|503)H|754J|105S|(153|203)W)I",
    "", "", ""
  },
  { "SAMSUNG SpinPoint F3 RE", // tested with HE103SJ/1AJ30001
    "SAMSUNG HE(502H|754J|103S)J",
    "", "", ""
  },
  { "Seagate Samsung Spinpoint F4", // tested with ST250DM001 HD256GJ/1AR10001
    "ST(250|320)DM001 HD(256G|322G|323H)J",
    "", "", ""
  },
  { "SAMSUNG SpinPoint F4 EG (AF)",// tested with HD204UI/1AQ10001(buggy|fixed)
    "SAMSUNG HD(155|204)UI",
    "", // 1AQ10001
    "Using smartmontools or hdparm with this\n"
    "drive may result in data loss due to a firmware bug.\n"
    "****** THIS DRIVE MAY OR MAY NOT BE AFFECTED! ******\n"
    "Buggy and fixed firmware report same version number!\n"
    "See the following web pages for details:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/223571en\n"
    "http://www.smartmontools.org/wiki/SamsungF4EGBadBlocks",
    ""
  },
  { "SAMSUNG SpinPoint S250", // tested with HD200HJ/KF100-06
    "SAMSUNG HD(162|200|250)HJ",
    "", "", ""
  },
  { "SAMSUNG SpinPoint T133", // tested with HD300LJ/ZT100-12, HD400LJ/ZZ100-14, HD401LJ/ZZ100-15
    "SAMSUNG HD(250KD|(30[01]|320|40[01])L[DJ])",
    "", "", ""
  },
  { "SAMSUNG SpinPoint T166", // tested with HD252KJ/CM100-11, HD501LJ/CR100-1[01]
    "SAMSUNG HD(080G|160H|252K|32[01]K|403L|50[01]L)J",
    "", "",
    "-v 197,increasing" // at least HD501LJ/CR100-11
  },
  { "SAMSUNG SpinPoint P120", // VF100-37 firmware, tested with SP2514N/VF100-37
    "SAMSUNG SP(16[01]3|2[05][01]4)[CN]",
    "VF100-37",
    "",
    "-F samsung3"
  },
  { "SAMSUNG SpinPoint P120", // other firmware, tested with SP2504C/VT100-33
    "SAMSUNG SP(16[01]3|2[05][01]4)[CN]",
    "",
    "May need -F samsung3 enabled; see manual for details.",
    ""
  },
  { "SAMSUNG SpinPoint P80 SD", // tested with HD160JJ/ZM100-33, SAMSUNG HD080HJ/P/ZH100-34
    "SAMSUNG HD(080H|120I|160J)J(/P)?",
    "", "", ""
  },
  { "SAMSUNG SpinPoint P80", // BH100-35 firmware, tested with SP0842N/BH100-35
    "SAMSUNG SP(0451|08[0124]2|12[0145]3|16[0145]4)[CN]",
    "BH100-35",
    "",
    "-F samsung3"
  },
  { "SAMSUNG SpinPoint P80", // firmware *-35 or later
    "SAMSUNG SP(0451|08[0124]2|12[0145]3|16[0145]4)[CN]",
    ".*-3[5-9]",
    "May need -F samsung3 enabled; see manual for details.",
    ""
  },
  { "SAMSUNG SpinPoint P80", // firmware *-25...34, tested with
      // SP0401N/TJ100-30, SP1614C/SW100-25 and -34
    "SAMSUNG SP(04[05]1|08[0124]2|12[0145]3|16[0145]4)[CN]",
    ".*-(2[5-9]|3[0-4])",
    "",
    "-v 9,halfminutes -v 198,increasing"
  },
  { "SAMSUNG SpinPoint P80", // firmware *-23...24, tested with
    // SP0802N/TK100-23,
    // SP1213N/TL100-23,
    // SP1604N/TM100-23 and -24
    "SAMSUNG SP(0451|08[0124]2|12[0145]3|16[0145]4)[CN]",
    ".*-2[34]",
    "",
    "-v 9,halfminutes -F samsung2"
  },
  { "SAMSUNG SpinPoint P80", // unknown firmware
    "SAMSUNG SP(0451|08[0124]2|12[0145]3|16[0145]4)[CN]",
    "",
    "May need -F samsung2 or -F samsung3 enabled; see manual for details.",
    ""
  },
  { "SAMSUNG SpinPoint M40/60/80", // tested with HM120IC/AN100-16, HM160JI/AD100-16
    "SAMSUNG HM(0[468]0H|120I|1[026]0J)[CI]",
    "",
    "",
    "-v 9,halfminutes"
  },
  { "SAMSUNG SpinPoint M5", // tested with HM160HI/HH100-12
    "SAMSUNG HM(((061|080)G|(121|160)H|250J)I|160HC)",
    "", "", ""
  },
  { "SAMSUNG SpinPoint M6", // tested with HM320JI/2SS00_01 M6
    "SAMSUNG HM(251J|320[HJ]|[45]00L)I",
    "", "", ""
  },
  { "SAMSUNG SpinPoint M7", // tested with HM500JI/2AC101C4
    "SAMSUNG HM(250H|320I|[45]00J)I",
    "", "", ""
  },
  { "SAMSUNG SpinPoint M7E (AF)", // tested with HM321HI/2AJ10001, HM641JI/2AJ10001
    "SAMSUNG HM(161G|(251|321)H|501I|641J)I",
    "", "", ""
  },
  { "Seagate Samsung SpinPoint M7E", // tested with ST640LM000 HM641JI/2AJ10001
    "ST(160|250|320|500|640)LM00[01] HM[0-9]*[GHIJ]I",
    "", "", ""
  },
  { "SAMSUNG SpinPoint M7U (USB)", // tested with HM252HX/2AC101C4
    "SAMSUNG HM(162H|252H|322I|502J)X",
    "", "", ""
  },
  { "SAMSUNG SpinPoint M8 (AF)", // tested with HN-M101MBB/2AR10001
    "SAMSUNG HN-M(250|320|500|640|750|101)MBB",
    "", "", ""
  },
  { "Seagate Samsung SpinPoint M8 (AF)", // tested with
      // ST750LM022 HN-M750MBB/2AR10001, ST320LM001 HN-M320MBB/2AR10002,
      // APPLE HDD ST500LM012/2BA30003
    "ST(250|320|500|640|750|1000)LM0[012][124] HN-M[0-9]*MBB|"
    "APPLE HDD ST500LM012",
    "", "", ""
  },
  { "SAMSUNG SpinPoint M8U (USB)", // tested with HN-M500XBB/2AR10001
    "SAMSUNG HN-M(320|500|750|101)XBB",
    "", "", ""
  },
  { "Seagate Samsung SpinPoint M8U (USB)", // tested with ST1000LM025 HN-M101ABB/2AR10001,
      // ST1000LM025 HN-M101ABB/2BA30003 (0x04e8:0x61b6)
    "ST(250|320|500|640|750|1000)LM0[012][3459] HN-M[0-9]*ABB",
    "", "", ""
  },
  { "Seagate Samsung SpinPoint M9T", // tested with ST2000LM003 HN-M201RAD/2BC10003
      // (Seagate Expansion Portable)
    "ST(1500|2000)LM0(03|04|06|07|10) HN-M[0-9]*RAD",
    "", "", ""
  },
  // Flash accelerated, no SMART info in the specs
  // ST1000LX015-1U7172/SDM1
  { "Seagate FireCuda 2.5", // 
    "ST(500|1000|2000)LX0(01|15|25)-.*",
    "", "", "-v 240,msec24hour32 "
  },
  // ST1000DX002/CC41
  { "Seagate FireCuda 3.5", // ST2000DX002-2DV164/CC41
    "ST[12]000DX002-.*",
    "", "", "-v 240,msec24hour32 "
  },
  { "Seagate Samsung SpinPoint M9TU (USB)", // tested with ST1500LM008 HN-M151AAD/2BC10001
       // (0x04e8:0x61b5), ST2000LM005 HN-M201AAD2BC10001 (0x04e8:0x61b4)
    "ST(1500|2000)LM00[58] HN-M[0-9]*AAD",
    "", "", ""
  },
  { "SAMSUNG SpinPoint MP5", // tested with HM250HJ/2AK10001
    "SAMSUNG HM(250H|320H|500J|640J)J",
    "", "", ""
  },
  { "SAMSUNG SpinPoint MT2", // tested with HM100UI/2AM10001
    "SAMSUNG HM100UI",
    "", "", ""
  },
  { "SAMSUNG HM100UX (S2 Portable)", // tested with HM100UX/2AM10001
    "SAMSUNG HM100UX",
    "", "", ""
  },
  { "SAMSUNG SpinPoint M", // tested with MP0402H/UC100-11
    "SAMSUNG MP0(302|402|603|804)H",
    "",
    "",
    "-v 9,halfminutes"
  },
  { "SAMSUNG SpinPoint N3U-3 (USB, 4KiB LLS)", // tested with HS25YJZ/3AU10-01
    "SAMSUNG HS(122H|2[05]YJ)Z",
    "", "", ""
  },
  { "SK hynix SATA SSDs",
    "SK ?hynix SC(210|300|308|313).*|" // tested with
      // SK hynix SC210 mSATA 256GB/20002L00,
      // SKhynix SC300 HFS256G32MND-3210A/20131P00,
      // SK hynix SC308 SATA 128GB/30001P10,
      // SK hynix SC313 HFS256G32TNF-N3A0A/70000P10
    "HFS(128|256|512)G32MND-(2200|3210)A|" // HFS128G32MND-2200A/20200L00,
      // HFS512G32MND-3210A/20100P00
    "HFS(120|250|500)G32TND-N1A2A", // HFS500G32TND-N1A2A/30000P10
    "", "",
    "-v 5,raw48,Retired_Block_Count "
    "-v 100,raw48,Total_Erase_Count "
    "-v 168,raw48,Min_Erase_Count "
    "-v 169,raw48,Max_Erase_Count "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Wear_Leveling_Count "
    "-v 174,raw48,Unexpect_Power_Loss_Ct "
    "-v 176,raw48,Unused_Rsvd_Blk_Cnt_Tot "
    "-v 180,raw48,Erase_Fail_Count "
    "-v 181,raw48,Non4k_Aligned_Access "
    "-v 183,raw48,SATA_Downshift_Count "
    "-v 201,raw48,Percent_Lifetime_Remain "
    "-v 212,raw48,Phy_Error_Count "
    "-v 231,raw48,SSD_Life_Left "
    "-v 241,raw48,Total_Writes_GiB "
    "-v 242,raw48,Total_Reads_GiB "
    "-v 243,raw48,Total_Media_Writes "
    "-v 250,raw48,Read_Retry_Count "
  },
  { "Maxtor Fireball 541DX",
    "Maxtor 2B0(0[468]|1[05]|20)H1",
    "",
    "",
    "-v 9,minutes -v 194,unknown"
  },
  { "Maxtor Fireball 3",
    "Maxtor 2F0[234]0[JL]0",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 1280 ATA",  // no self-test log, ATA2-Fast
    "Maxtor 8(1280A2|2160A4|2560A4|3840A6|4000A6|5120A8)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 2160 Ultra ATA",
    "Maxtor 8(2160D2|3228D3|3240D3|4320D4|6480D6|8400D8|8455D8)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 2880 Ultra ATA",
    "Maxtor 9(0510D4|0576D4|0648D5|0720D5|0840D6|0845D6|0864D6|1008D7|1080D8|1152D8)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 3400 Ultra ATA",
    "Maxtor 9(1(360|350|202)D8|1190D7|10[12]0D6|0840D5|06[48]0D4|0510D3|1(350|202)E8|1010E6|0840E5|0640E4)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax D540X-4G",
    "Maxtor 4G(120J6|160J[68])",
    "",
    "",
    "-v 9,minutes -v 194,unknown"
  },
  { "Maxtor DiamondMax D540X-4K",
    "MAXTOR 4K(020H1|040H2|060H3|080H4)",
    "", "", ""
  },
  { "Maxtor DiamondMax Plus D740X",
    "MAXTOR 6L0(20[JL]1|40[JL]2|60[JL]3|80[JL]4)",
    "", "", ""
  },
  { "Maxtor DiamondMax Plus 5120 Ultra ATA 33",
    "Maxtor 9(0512D2|0680D3|0750D3|0913D4|1024D4|1360D6|1536D6|1792D7|2048D8)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax Plus 6800 Ultra ATA 66",
    "Maxtor 9(2732U8|2390U7|204[09]U6|1707U5|1366U4|1024U3|0845U3|0683U2)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax D540X-4D",
    "Maxtor 4D0(20H1|40H2|60H3|80H4)",
    "",
    "",
    "-v 9,minutes -v 194,unknown"
  },
  { "Maxtor DiamondMax 16",
    "Maxtor 4(R0[68]0[JL]0|R1[26]0L0|A160J0|R120L4)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 4320 Ultra ATA",
    "Maxtor (91728D8|91512D7|91303D6|91080D5|90845D4|90645D3|90648D[34]|90432D2)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 17 VL",
    "Maxtor 9(0431U1|0641U2|0871U2|1301U3|1741U4)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 20 VL",
    "Maxtor (94091U8|93071U6|92561U5|92041U4|91731U4|91531U3|91361U3|91021U2|90841U2|90651U2)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax VL 30",  // U: ATA66, H: ATA100
    "Maxtor (33073U4|32049U3|31536U2|30768U1|33073H4|32305H3|31536H2|30768H1)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 36",
    "Maxtor (93652U8|92739U6|91826U4|91369U3|90913U2|90845U2|90435U1)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 40 ATA 66",
    "Maxtor 9(0684U2|1024U2|1362U3|1536U3|2049U4|2562U5|3073U6|4098U8)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax Plus 40 (Ultra ATA 66 and Ultra ATA 100)",
    "Maxtor (54098[UH]8|53073[UH]6|52732[UH]6|52049[UH]4|51536[UH]3|51369[UH]3|51024[UH]2)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 40 VL Ultra ATA 100",
    "Maxtor 3(1024H1|1535H2|2049H2|3073H3|4098H4)( B)?",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax Plus 45 Ulta ATA 100",
    "Maxtor 5(4610H6|4098H6|3073H4|2049H3|1536H2|1369H2|1023H2)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 60 ATA 66",
    "Maxtor 9(1023U2|1536U2|2049U3|2305U3|3073U4|4610U6|6147U8)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 60 ATA 100",
    "Maxtor 9(1023H2|1536H2|2049H3|2305H3|3073H4|4098H6|4610H6|6147H8)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax Plus 60",
    "Maxtor 5T0(60H6|40H4|30H3|20H2|10H1)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 80",
    "Maxtor (98196H8|96147H6)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 536DX",
    "Maxtor 4W(100H6|080H6|060H4|040H3|030H2)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax Plus 8",
    "Maxtor 6(E0[234]|K04)0L0",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 10 (ATA/133 and SATA/150)",
    "Maxtor 6(B(30|25|20|16|12|10|08)0[MPRS]|L(080[MLP]|(100|120)[MP]|160[MP]|200[MPRS]|250[RS]|300[RS]))0",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 10 (SATA/300)",
    "Maxtor 6V(080E|160E|200E|250F|300F|320F)0",
    "", "", ""
  },
  { "Maxtor DiamondMax Plus 9",
    "Maxtor 6Y((060|080|120|160)L0|(060|080|120|160|200|250)P0|(060|080|120|160|200|250)M0)",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor DiamondMax 11",
    "Maxtor 6H[45]00[FR]0",
    "", "", ""
  },
  { "Maxtor DiamondMax 17",
    "Maxtor 6G(080L|160[PE])0",
    "", "", ""
  },
  { "Seagate Maxtor DiamondMax 20",
    "MAXTOR STM3(40|80|160)[28]1[12]0?AS?",
    "", "", ""
  },
  { "Seagate Maxtor DiamondMax 21", // tested with MAXTOR STM3250310AS/3.AAF
    "MAXTOR STM3(80[28]15|160215|250310|(250|320)820|320620|500630)AS?",
    "", "", ""
  },
  { "Seagate Maxtor DiamondMax 22", // fixed firmware
    "(MAXTOR )?STM3(500320|750330|1000340)AS?",
    "MX1A", // http://knowledge.seagate.com/articles/en_US/FAQ/207969en
    "", ""
  },
  { "Seagate Maxtor DiamondMax 22", // fixed firmware
    "(MAXTOR )?STM3(160813|320614|640323|1000334)AS?",
    "MX1B", // http://knowledge.seagate.com/articles/en_US/FAQ/207975en
    "", ""
  },
  { "Seagate Maxtor DiamondMax 22", // buggy firmware
    "(MAXTOR )?STM3(500320|750330|1000340)AS?",
    "MX15",
    "There are known problems with these drives,\n"
    "AND THIS FIRMWARE VERSION IS AFFECTED,\n"
    "see the following Seagate web pages:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207969en",
    ""
  },
  { "Seagate Maxtor DiamondMax 22", // unknown firmware
    "(MAXTOR )?STM3(160813|32061[34]|500320|640323|750330|10003(34|40))AS?",
    "",
    "There are known problems with these drives,\n"
    "see the following Seagate web pages:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207969en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207975en",
    ""
  },
  { "Seagate Maxtor DiamondMax 23", // new firmware
    "STM3((160|250)31|(320|500)41|(750|1000)52)8AS?",
    "CC3[D-Z]",
    "", ""
  },
  { "Seagate Maxtor DiamondMax 23", // unknown firmware
    "STM3((160|250)31|(320|500)41|(750|1000)52)8AS?",
    "",
    "A firmware update for this drive may be available,\n"
    "see the following Seagate web pages:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/213911en",
    ""
  },
  { "Maxtor MaXLine Plus II",
    "Maxtor 7Y250[PM]0",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor MaXLine II",
    "Maxtor [45]A(25|30|32)0[JN]0",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor MaXLine III (ATA/133 and SATA/150)",
    "Maxtor 7L(25|30)0[SR]0",
    "",
    "",
    "-v 9,minutes"
  },
  { "Maxtor MaXLine III (SATA/300)",
    "Maxtor 7V(25|30)0F0",
    "", "", ""
  },
  { "Maxtor MaXLine Pro 500",  // There is also a 7H500R0 model, but I
    "Maxtor 7H500F0",               // haven't added it because I suspect
    "",                               // it might need vendoropts_9_minutes
    "", ""                            // and nobody has submitted a report yet
  },
  { "", // HITACHI_DK14FA-20B
    "HITACHI_DK14FA-20B",
    "",
    "",
    "-v 9,minutes -v 193,loadunload"
  },
  { "HITACHI Travelstar DK23XX/DK23XXB",
    "HITACHI_DK23..-..B?",
    "",
    "",
    "-v 9,minutes -v 193,loadunload"
  },
  { "Hitachi Endurastar J4K20/N4K20 (formerly DK23FA-20J)",
    "(HITACHI_DK23FA-20J|HTA422020F9AT[JN]0)",
    "",
    "",
    "-v 9,minutes -v 193,loadunload"
  },
  { "Hitachi Endurastar J4K30/N4K30",
    "HE[JN]4230[23]0F9AT00",
    "",
    "",
    "-v 9,minutes -v 193,loadunload"
  },
  { "Hitachi Travelstar C4K60",  // 1.8" slim drive
    "HTC4260[23]0G5CE00|HTC4260[56]0G8CE00",
    "",
    "",
    "-v 9,minutes -v 193,loadunload"
  },
  { "IBM Travelstar 4GT",
    "IBM-DTCA-2(324|409)0",
    "", "", ""
  },
  { "IBM Travelstar 6GN",
    "IBM-DBCA-20(324|486|648)0",
    "", "", ""
  },
  { "IBM Travelstar 25GS, 18GT, and 12GN",
    "IBM-DARA-2(25|18|15|12|09|06)000",
    "", "", ""
  },
  { "IBM Travelstar 14GS",
    "IBM-DCYA-214000",
    "", "", ""
  },
  { "IBM Travelstar 4LP",
    "IBM-DTNA-2(180|216)0",
    "", "", ""
  },
  { "IBM Travelstar 48GH, 30GN, and 15GN",
    "(IBM-|Hitachi )?IC25(T048ATDA05|N0(30|20|15|12|10|07|06|05)ATDA04)-.",
    "", "", ""
  },
  { "IBM Travelstar 32GH, 30GT, and 20GN",
    "IBM-DJSA-2(32|30|20|10|05)",
    "", "", ""
  },
  { "IBM Travelstar 4GN",
    "IBM-DKLA-2(216|324|432)0",
    "", "", ""
  },
  { "IBM/Hitachi Travelstar 60GH and 40GN",
    "(IBM-|Hitachi )?IC25(T060ATC[SX]05|N0[4321]0ATC[SX]04)-.",
    "", "", ""
  },
  { "IBM/Hitachi Travelstar 40GNX",
    "(IBM-|Hitachi )?IC25N0[42]0ATC[SX]05-.",
    "", "", ""
  },
  { "Hitachi Travelstar 80GN",
    "(Hitachi )?IC25N0[23468]0ATMR04-.",
    "", "", ""
  },
  { "Hitachi Travelstar 4K40",
    "(Hitachi )?HTS4240[234]0M9AT00",
    "", "", ""
  },
  { "Hitachi Travelstar 4K120",
    "(Hitachi )?(HTS4212(60|80|10|12)H9AT00|HTS421260G9AT00)",
    "", "", ""
  },
  { "Hitachi Travelstar 5K80",
    "(Hitachi )?HTS5480[8642]0M9AT00",
    "", "", ""
  },
  { "Hitachi Travelstar 5K100",
    "(Hitachi )?HTS5410[1864]0G9(AT|SA)00",
    "", "", ""
  },
  { "Hitachi Travelstar E5K100",
    "(Hitachi )?HTE541040G9(AT|SA)00",
    "", "", ""
  },
  { "Hitachi Travelstar 5K120",
    "(Hitachi )?HTS5412(60|80|10|12)H9(AT|SA)00",
    "", "", ""
  },
  { "Hitachi Travelstar 5K160",
    "(Hitachi |HITACHI )?HTS5416([468]0|1[26])J9(AT|SA)00",
    "", "", ""
  },
  { "Hitachi Travelstar E5K160",
    "(Hitachi )?HTE5416(12|16|60|80)J9(AT|SA)00",
    "", "", ""
  },
  { "Hitachi Travelstar 5K250",
    "(Hitachi |HITACHI )?HTS5425(80|12|16|20|25)K9(A3|SA)00",
    "", "", ""
  },
  { "Hitachi Travelstar 5K320", // tested with HITACHI HTS543232L9SA00/FB4ZC4EC,
    // Hitachi HTS543212L9SA02/FBBAC52F
    "(Hitachi |HITACHI )?HT(S|E)5432(80|12|16|25|32)L9(A3(00)?|SA0[012])",
    "", "", ""
  },
  { "Hitachi/HGST Travelstar Z5K320", // tested with Hitachi HTS543232A7A384/ES2OA70K
    "(Hitachi|HGST) HT[ES]5432(16|25|32)A7A38[145]",
    "", "", ""
  },
  { "Hitachi Travelstar 5K500.B", // tested with Hitachi HTS545050B9SA00/PB4OC60X
    "(Hitachi )?HT[ES]5450(12|16|25|32|40|50)B9(A30[01]|SA00)",
    "", "", ""
  },
  { "Hitachi/HGST Travelstar Z5K500", // tested with HGST HTS545050A7E380/GG2OAC90,
      // Hitachi HTS545032A7E380/GGBOA7A0, HGST HTS545050A7E680/GR2OA230,
      // APPLE HDD HTS545050A7E362/GG2AB990
    "(Hitachi|HGST|APPLE HDD) HT[ES]5450(25|32|50)A7E(362|38[01]|680)",
    "", "", ""
  },
  { "Hitachi/HGST Travelstar 5K750", // tested with Hitachi HTS547575A9E384/JE4OA60A,
       // APPLE HDD HTS547550A9E384/JE3AD70F
    "(Hitachi|APPLE HDD) HT[ES]5475(50|64|75)A9E38[14]",
    "", "", ""
  },
  { "HGST Travelstar 5K1000", // tested with HGST HTS541010A9E680/JA0OA560,
      // HGST HTS541075A9E680/JA2OA560
    "HGST HT[ES]5410(64|75|10)A9E68[01]",
    "", "", ""
  },
  { "HGST Travelstar Z5K1000", // tested with HGST HTS541010A7E630/SE0OA4A0
    "HGST HTS5410(75|10)A7E63[015]",
    "", "", ""
  },
  { "HGST Travelstar 5K1500", // tested with HGST HTS541515A9E630/KA0OA500
    "HGST HT[ES]541515A9E63[015]",
    "", "", ""
  },
  { "Hitachi Travelstar 7K60",
    "(Hitachi )?HTS726060M9AT00",
    "", "", ""
  },
  { "Hitachi Travelstar E7K60",
    "(Hitachi )?HTE7260[46]0M9AT00",
    "", "", ""
  },
  { "Hitachi Travelstar 7K100",
    "(Hitachi )?HTS7210[168]0G9(AT|SA)00",
    "", "", ""
  },
  { "Hitachi Travelstar E7K100",
    "(Hitachi )?HTE7210[168]0G9(AT|SA)00",
    "", "", ""
  },
  { "Hitachi Travelstar 7K200", // tested with HITACHI HTS722016K9SA00/DCDZC75A
    "(Hitachi |HITACHI )?HTS7220(80|10|12|16|20)K9(A3|SA)00",
    "", "", ""
  },
  { "Hitachi Travelstar 7K320", // tested with
    // HTS723225L9A360/FCDOC30F, HTS723216L9A362/FC2OC39F
    "(Hitachi )?HT[ES]7232(80|12|16|25|32)L9(A300|A36[02]|SA61)",
    "", "", ""
  },
  { "Hitachi Travelstar Z7K320", // tested with HITACHI HTS723232A7A364/EC2ZB70B
    "(HITACHI )?HT[ES]7232(16|25|32)A7A36[145]",
    "", "", ""
  },
  { "Hitachi Travelstar 7K500", // tested with Hitachi HTS725050A9A360/PC4OC70D,
    // HITACHI HTS725032A9A364/PC3ZC70F
    "(Hitachi |HITACHI )?HT[ES]7250(12|16|25|32|50)A9A36[02-5]",
    "", "", ""
  },
  { "Hitachi/HGST Travelstar Z7K500", // tested with HITACHI HTS725050A7E630/GH2ZB390,
      // HGST HTS725050A7E630/GH2OA420, HGST HTS725050A7E630/GH2OA530
    "(HITACHI|HGST) HT[ES]7250(25|32|50)A7E63[015]",
    "", "", ""
  },
  { "Hitachi/HGST Travelstar 7K750", // tested with Hitachi HTS727550A9E364/JF3OA0E0,
      // Hitachi HTS727575A9E364/JF4OA0D0
    "(Hitachi|HGST) HT[ES]7275(50|64|75)A9E36[14]",
    "", "", ""
  },
  { "HGST Travelstar 7K1000", // tested with HGST HTS721010A9E630/JB0OA3B0
    // HGST HTS721075A9E630/JB2OA3J0
    "HGST HT[ES]7210(10|75)A9E63[01]",
    "", "", ""
  },
  { "IBM Deskstar 14GXP and 16GP",
    "IBM-DTTA-3(7101|7129|7144|5032|5043|5064|5084|5101|5129|5168)0",
    "", "", ""
  },
  { "IBM Deskstar 25GP and 22GXP",
    "IBM-DJNA-3(5(101|152|203|250)|7(091|135|180|220))0",
    "", "", ""
  },
  { "IBM Deskstar 37GP and 34GXP",
    "IBM-DPTA-3(5(375|300|225|150)|7(342|273|205|136))0",
    "", "", ""
  },
  { "IBM/Hitachi Deskstar 120GXP",
    "(IBM-)?IC35L((020|040|060|080|120)AVVA|0[24]0AVVN)07-[01]",
    "", "", ""
  },
  { "IBM/Hitachi Deskstar GXP-180",
    "(IBM-)?IC35L(030|060|090|120|180)AVV207-[01]",
    "", "", ""
  },
  { "Hitachi CinemaStar 5K320", // tested with Hitachi HCS5C3225SLA380/STBOA37H
    "Hitachi HCS5C32(25|32)SLA380",
    "", "", ""
  },
  { "Hitachi CinemaStar 5K1000", // Hitachi HCS5C1010CLA382/JC4OA3EA
    "Hitachi HCS5C10(10|75|50|32|25|16)CLA382",
    "", "", ""
  },
  { "Hitachi Deskstar 5K3000", // tested with HDS5C3030ALA630/MEAOA5C0,
       // Hitachi HDS5C3020BLE630/MZ4OAAB0 (OEM, Toshiba Canvio Desktop)
    "(Hitachi )?HDS5C30(15|20|30)(ALA|BLE)63[02].*",
    "", "", ""
  },
  { "Hitachi Deskstar 5K4000", // tested with HDS5C4040ALE630/MPAOA250
    "(Hitachi )?HDS5C40(30|40)ALE63[01].*",
    "", "", ""
  },
  { "Hitachi Deskstar 7K80",
    "(Hitachi )?HDS7280([48]0PLAT20|(40)?PLA320|80PLA380).*",
    "", "", ""
  },
  { "Hitachi Deskstar 7K160",
    "(Hitachi )?HDS7216(80|16)PLA[3T]80.*",
    "", "", ""
  },
  { "Hitachi Deskstar 7K250",
    "(Hitachi )?HDS7225((40|80|12|16)VLAT20|(12|16|25)VLAT80|(80|12|16|25)VLSA80)",
    "", "", ""
  },
  { "Hitachi Deskstar 7K250 (SUN branded)",
    "HITACHI HDS7225SBSUN250G.*",
    "", "", ""
  },
  { "Hitachi Deskstar T7K250",
    "(Hitachi )?HDT7225((25|20|16)DLA(T80|380))",
    "", "", ""
  },
  { "Hitachi Deskstar 7K400",
    "(Hitachi )?HDS724040KL(AT|SA)80",
    "", "", ""
  },
  { "Hitachi Deskstar 7K500",
    "(Hitachi )?HDS725050KLA(360|T80)",
    "", "", ""
  },
  { "Hitachi Deskstar P7K500",
    "(Hitachi )?HDP7250(16|25|32|40|50)GLA(36|38|T8)0",
    "", "", ""
  },
  { "Hitachi Deskstar T7K500",
    "(Hitachi )?HDT7250(25|32|40|50)VLA(360|380|T80)",
    "", "", ""
  },
  { "Hitachi Deskstar 7K1000",
    "(Hitachi )?HDS7210(50|75|10)KLA330",
    "", "", ""
  },
  { "Hitachi Deskstar 7K1000.B",
    "(Hitachi )?HDT7210((16|25)SLA380|(32|50|64|75|10)SLA360)",
    "", "", ""
  },
  { "Hitachi Deskstar 7K1000.C", // tested with Hitachi HDS721010CLA330/JP4OA3MA,
      // Hitachi HDS721025CLA682/JP1OA41A
    "(Hitachi )?HDS7210((16|25)CLA[36]82|(32|50)CLA[36]62|(64|75|10)CLA[36]3[02])",
    "", "", ""
  },
  { "Hitachi Deskstar 7K1000.D", // tested with HDS721010DLE630/MS2OA5Q0
    "Hitachi HDS7210(25|32|50|75|10)DLE630",
    "", "", ""
  },
  { "Hitachi Deskstar E7K1000", // tested with HDE721010SLA330/ST6OA31B
    "Hitachi HDE7210(50|75|10)SLA330",
    "", "", ""
  },
  { "Hitachi Deskstar 7K2000",
    "Hitachi HDS722020ALA330",
    "", "", ""
  },
  { "Hitachi Deskstar 7K3000", // tested with Hitachi HDS723030ALA640/MKAOA3B0,
      // Hitachi HDS723030BLE640/MX6OAAB0
    "Hitachi HDS7230((15|20)BLA642|30ALA640|30BLE640)",
    "", "", ""
  },
  { "Hitachi/HGST Deskstar 7K4000", // tested with Hitachi HDS724040ALE640/MJAOA250,
      // HGST HDS724040ALE640/MJAOA580
    "(Hitachi|HGST) HDS724040ALE640",
    "", "", ""
  },
  { "HGST Deskstar NAS", // tested with HGST HDN724040ALE640/MJAOA5E0,
       // HGST HDN726050ALE610/APGNT517, HGST HDN726060ALE610/APGNT517
    "HGST HDN72(4030|4040|6050|6060)ALE6[14]0",
    "", "", ""
  },
  { "Hitachi Ultrastar A7K1000", // tested with
    // HUA721010KLA330      44X2459 42C0424IBM/GKAOAB4A
    "(Hitachi )?HUA7210(50|75|10)KLA330.*",
    "", "", ""
  },
  { "Hitachi Ultrastar A7K2000", // tested with
    // HUA722010CLA330      43W7629 42C0401IBM
    "(Hitachi )?HUA7220(50|10|20)[AC]LA33[01].*",
    "", "", ""
  },
  { "Hitachi Ultrastar 7K3000", // tested with Hitachi HUA723030ALA640/MKAOA580,
      // Hitachi HUA723020ALA641/MK7OA840
    "Hitachi HUA7230(20|30)ALA64[01]",
    "", "", ""
  },
  { "Hitachi/HGST Ultrastar 7K4000", // tested with Hitachi HUS724040ALE640/MJAOA3B0,
      // HGST HUS724040ALE640/MJAOA580, HGST HUS724020ALA640/MF6OAA70
    "(Hitachi|HGST) HUS7240(20|30|40)AL[AE]64[01]",
    "", "", ""
  },
  { "Hitachi/HGST Ultrastar 7K2", //
    "(Hitachi|HGST) HUS722T[12]TALA604",
    "", "",
    "-v 16,raw48,Gas_Gauge"
  },
  { "HGST Ultrastar 7K6000", // tested with HGST HUS726060ALE614/APGNW517
    "HGST HUS7260[2456]0AL[AEN]61[014]",
    "", "", ""
  },
  { "HGST Ultrastar He6", // tested with HGST HUS726060ALA640/AHGNT1E2
    "HGST HUS726060ALA64[01]",
    "", "",
    "-v 22,raw48,Helium_Level"
  },
  { "HGST Ultrastar He8", // tested with HGST HUH728060ALE600/GR2OA230
    "HGST HUH7280(60|80)AL[EN]60[014]",
    "", "",
    "-v 22,raw48,Helium_Level"
  },
  { "HGST Ultrastar He10", // tested with HGST HUH7210100ALE600/0F27452
    "HGST HUH7210(08|10)AL[EN]60[014]",
    "", "",
    "-v 22,raw48,Helium_Level"
  },
  { "HGST MegaScale 4000", // tested with HGST HMS5C4040ALE640/MPAOA580
    "HGST HMS5C4040[AB]LE64[01]", // B = DC 4000.B
    "", "", ""
  },
  { "Toshiba 2.5\" HDD (10-20 GB)",
    "TOSHIBA MK(101[67]GAP|15[67]GAP|20(1[678]GAP|(18|23)GAS))",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD (30-60 GB)",
    "TOSHIBA MK((6034|4032)GSX|(6034|4032)GAX|(6026|4026|4019|3019)GAXB?|(6025|6021|4025|4021|4018|3025|3021|3018)GAS|(4036|3029)GACE?|(4018|3017)GAP)",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD (80 GB and above)",
    "TOSHIBA MK(80(25GAS|26GAX|32GAX|32GSX)|10(31GAS|32GAX)|12(33GAS|34G[AS]X)|2035GSS)",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..37GSX", // tested with TOSHIBA MK1637GSX/DL032C
    "TOSHIBA MK(12|16)37GSX",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..46GSX", // tested with TOSHIBA MK1246GSX/LB213M
    "TOSHIBA MK(80|12|16|25)46GSX",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..50GACY", // tested with TOSHIBA MK8050GACY/TF105A
    "TOSHIBA MK8050GACY",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..34GSX", // tested with TOSHIBA MK8034GSX/AH301E
    "TOSHIBA MK(80|12|10)34GSX",
    "", "", ""
  },
  //
  { "Toshiba 2.5\" HDD MK..32GSX", // tested with TOSHIBA MK1032GSX/AS021G
    "TOSHIBA MK(10|80|60|40)32GSX",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..51GSY", // tested with TOSHIBA MK1251GSY/LD101D
    "TOSHIBA MK(80|12|16|25)51GSY",
    "",
    "",
    "-v 9,minutes"
  },
  { "Toshiba 2.5\" HDD MK..52GSX",
    "TOSHIBA MK(80|12|16|25|32)52GSX",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..55GSX", // tested with TOSHIBA MK5055GSX/FG001A, MK3255GSXF/FH115B
    "TOSHIBA MK(12|16|25|32|40|50)55GSXF?",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..56GSY", // tested with TOSHIBA MK2556GSYF/LJ001D
    "TOSHIBA MK(16|25|32|50)56GSYF?",
    "",
    "",
    "-v 9,minutes"
  },
  { "Toshiba 2.5\" HDD MK..59GSXP (AF)",
    "TOSHIBA MK(32|50|64|75)59GSXP?",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..59GSM (AF)",
    "TOSHIBA MK(75|10)59GSM",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..61GSY[N]", // tested with TOSHIBA MK5061GSY/MC102E, MK5061GSYN/MH000A,
      // TOSHIBA MK2561GSYN/MH000D
    "TOSHIBA MK(16|25|32|50|64)61GSYN?",
    "",
    "",
    "-v 9,minutes" // TOSHIBA MK2561GSYN/MH000D
  },
  { "Toshiba 2.5\" HDD MK..61GSYB", // tested with TOSHIBA MK5061GSYB/ME0A
    "TOSHIBA MK(16|25|32|50|64)61GSYB",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..65GSX", // tested with TOSHIBA MK5065GSX/GJ003A, MK3265GSXN/GH012H,
      // MK5065GSXF/GP006B, MK2565GSX H/GJ003A
    "TOSHIBA MK(16|25|32|50|64)65GSX[FN]?( H)?", // "... H" = USB ?
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..75GSX", // tested with TOSHIBA MK7575GSX/GT001C
    "TOSHIBA MK(32|50|64|75)75GSX",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MK..76GSX", // tested with TOSHIBA MK3276GSX/GS002D
    "TOSHIBA MK(16|25|32|50|64)76GSX",
    "",
    "",
    "-v 9,minutes"
  },
  { "Toshiba 2.5\" HDD MQ01ABB...", // tested with TOSHIBA MQ01ABB200/AY000U
    "TOSHIBA MQ01ABB(100|150|200)",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MQ01ABC...", // tested with TOSHIBA MQ01ABC150/AQ001U
    "TOSHIBA MQ01ABC(100|150|200)",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MQ01ABD...", // tested with TOSHIBA MQ01ABD100/AX001U,
      // TOSHIBA MQ01ABD100V/AX001Q
    "TOSHIBA MQ01ABD(025|032|050|064|075|100)V?",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MQ01ABF...", // tested with TOSHIBA MQ01ABF050/AM001J
    "TOSHIBA MQ01ABF(050|075|100)",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MQ01UBB... (USB 3.0)", // tested with TOSHIBA MQ01UBB200/AY000U (0x0480:0xa100),
      // TOSHIBA MQ01UBB200/34MATMZ5T (0x05ac:0x8406)
    "TOSHIBA MQ01UBB200",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MQ01UBD... (USB 3.0)", // tested with TOSHIBA MQ01UBD050/AX001U (0x0480:0xa007),
      // TOSHIBA MQ01UBD100/AX001U (0x0480:0x0201, 0x0480:0xa200),
      // TOSHIBA MQ01UBD050/AX101U (0x0480:0xa202)
    "TOSHIBA MQ01UBD(050|075|100)",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MQ03ABB...", // tested with TOSHIBA MQ03ABB300
    "TOSHIBA MQ03ABB[23]00",
    "", "", ""
  },
  { "Toshiba 2.5\" HDD MQ03UBB...", // tested with TOSHIBA MQ03UBB200/37I7T0NJT
    "TOSHIBA MQ03UBB(300|200|250)",
    "", "", ""
  },
  { "Toshiba 3.5\" HDD MK.002TSKB", // tested with TOSHIBA MK1002TSKB/MT1A
    "TOSHIBA MK(10|20)02TSKB",
    "", "", ""
  },
  { "Toshiba 3.5\" MG03ACAxxx(Y) Enterprise HDD", // tested with TOSHIBA MG03ACA100/FL1A
    "TOSHIBA MG03ACA[1234]00Y?",
    "", "", ""
  },
  { "Toshiba 3.5\" MD04ACA... Enterprise HDD", // tested with TOSHIBA MD04ACA500/FP1A
    "TOSHIBA MD04ACA[2345]00",
    "", "", ""
  },
  { "Toshiba 3.5\" MG04ACA... Enterprise HDD", // tested with TOSHIBA MG04ACA600A/FS2B
    "TOSHIBA MG04ACA[23456]00[AE].?",
    "", "", ""
  },
  { "Toshiba 3.5\" DT01ABA... Desktop HDD", // tested with TOSHIBA DT01ABA300/MZ6OABB0
    "TOSHIBA DT01ABA(100|150|200|300)",
    "", "", ""
  },
  { "Toshiba 3.5\" DT01ACA... Desktop HDD", // tested with TOSHIBA DT01ACA100/MS2OA750,
      // TOSHIBA DT01ACA200/MX4OABB0, TOSHIBA DT01ACA300/MX6OABB0
    "TOSHIBA DT01ACA(025|032|050|075|100|150|200|300)",
    "", "", ""
  },
  { "Toshiba X300", // tested with TOSHIBA HDWE160/FS2A
    "TOSHIBA HDWE1[456]0",
    "", "", ""
  },
  { "Toshiba P300", // tested with TOSHIBA HDWD120/MX4OACF0
    "TOSHIBA HDWD1(30|20|10|05)",
    "", "", ""
  },
  { "Toshiba 1.8\" HDD",
    "TOSHIBA MK[23468]00[4-9]GA[HL]",
    "", "", ""
  },
  { "Toshiba 1.8\" HDD MK..29GSG",
    "TOSHIBA MK(12|16|25)29GSG",
    "", "", ""
  },
  { "", // TOSHIBA MK6022GAX
    "TOSHIBA MK6022GAX",
    "", "", ""
  },
  { "Toshiba HG6 Series SSD", // TOSHIBA THNSNJ512GCST/JTRA0102
    // http://www.farnell.com/datasheets/1852757.pdf
    // TOSHIBA THNSFJ256GCSU/JULA1102
    // TOSHIBA THNSFJ256GDNU A/JYLA1102
    "TOSHIBA THNS[NF]J(060|128|256|512)G[BCAM8VD][SCN][TU].*",
    "", "", 
    "-v 167,raw48,SSD_Protect_Mode "
    "-v 168,raw48,SATA_PHY_Error_Count "
    "-v 169,raw48,Bad_Block_Count "
    "-v 173,raw48,Erase_Count "
  },
  { "", // TOSHIBA MK6409MAV
    "TOSHIBA MK6409MAV",
    "", "", ""
  },
  { "Toshiba MKx019GAXB (SUN branded)",
    "TOS MK[34]019GAXB SUN[34]0G",
    "", "", ""
  },
  { "Seagate Momentus",
    "ST9(20|28|40|48)11A",
    "", "", ""
  },
  { "Seagate Momentus 42",
    "ST9(2014|3015|4019)A",
    "", "", ""
  },
  { "Seagate Momentus 4200.2", // tested with ST960812A/3.05
    "ST9(100822|808210|60812|50212|402113|30219)A",
    "", "", ""
  },
  { "Seagate Momentus 5400.2",
    "ST9(808211|6082[12]|408114|308110|120821|10082[34]|8823|6812|4813|3811)AS?",
    "", "", ""
  },
  { "Seagate Momentus 5400.3",
    "ST9(4081[45]|6081[35]|8081[15]|100828|120822|160821)AS?",
    "", "", ""
  },
  { "Seagate Momentus 5400.3 ED",
    "ST9(4081[45]|6081[35]|8081[15]|100828|120822|160821)AB",
    "", "", ""
  },
  { "Seagate Momentus 5400.4",
    "ST9(120817|(160|200|250)827)AS",
    "", "", ""
  },
  { "Seagate Momentus 5400.5",
    "ST9((80|120|160)310|(250|320)320)AS",
    "", "", ""
  },
  { "Seagate Momentus 5400.6",
    "ST9(80313|160(301|314)|(12|25)0315|250317|(320|500)325|500327|640320)ASG?",
    "", "", ""
  },
  { "Seagate Momentus 5400.7",
    "ST9(160316|(250|320)310|(500|640)320)AS",
    "", "", ""
  },
  { "Seagate Momentus 5400.7 (AF)", // tested with ST9640322AS/0001BSM2
      // (device reports 4KiB LPS with 1 sector offset)
    "ST9(320312|400321|640322|750423)AS",
    "", "", ""
  },
  { "Seagate Momentus 5400 PSD", // Hybrid drives
    "ST9(808212|(120|160)8220)AS",
    "", "", ""
  },
  { "Seagate Momentus 7200.1",
    "ST9(10021|80825|6023|4015)AS?",
    "", "", ""
  },
  { "Seagate Momentus 7200.2",
    "ST9(80813|100821|120823|160823|200420)ASG?",
    "", "", ""
  },
  { "Seagate Momentus 7200.3",
    "ST9((80|120|160)411|(250|320)421)ASG?",
    "", "", ""
  },
  { "Seagate Momentus 7200.4",
    "ST9(160412|250410|320423|500420)ASG?",
    "", "", ""
  },
  { "Seagate Momentus 7200 FDE.2",
    "ST9((160413|25041[12]|320426|50042[12])AS|(16041[489]|2504[16]4|32042[67]|500426)ASG)",
    "", "", ""
  },
  { "Seagate Momentus 7200.5", // tested with ST9750420AS/0001SDM5, ST9750420AS/0002SDM1
    "ST9(50042[34]|64042[012]|75042[02])ASG?",
    "", "", ""
  },
  { "Seagate Momentus XT", // fixed firmware
    "ST9(2505610|3205620|5005620)AS",
    "SD2[68]", // http://knowledge.seagate.com/articles/en_US/FAQ/215451en
    "", ""
  },
  { "Seagate Momentus XT", // buggy firmware, tested with ST92505610AS/SD24
    "ST9(2505610|3205620|5005620)AS",
    "SD2[45]",
    "These drives may corrupt large files,\n"
    "AND THIS FIRMWARE VERSION IS AFFECTED,\n"
    "see the following web pages for details:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/215451en\n"
    "http://forums.seagate.com/t5/Momentus-XT-Momentus-Momentus/Momentus-XT-corrupting-large-files-Linux/td-p/109008\n"
    "http://superuser.com/questions/313447/seagate-momentus-xt-corrupting-files-linux-and-mac",
    ""
  },
  { "Seagate Momentus XT", // unknown firmware
    "ST9(2505610|3205620|5005620)AS",
    "",
    "These drives may corrupt large files,\n"
    "see the following web pages for details:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/215451en\n"
    "http://forums.seagate.com/t5/Momentus-XT-Momentus-Momentus/Momentus-XT-corrupting-large-files-Linux/td-p/109008\n"
    "http://superuser.com/questions/313447/seagate-momentus-xt-corrupting-files-linux-and-mac",
    ""
  },
  { "Seagate Momentus XT (AF)", // tested with ST750LX003-1AC154/SM12
    "ST750LX003-.*",
    "", "", ""
  },
  { "Seagate Momentus Thin", // tested with ST320LT007-9ZV142/0004LVM1
    "ST(160|250|320)LT0(07|09|11|14)-.*",
    "", "", ""
  },
  { "Seagate Laptop HDD", // tested with ST500LT012-9WS142/0001SDM1,
      // ST500LM021-1KJ152/0002LIM1, ST4000LM016-1N2170/0003
    "ST((25|32|50)0LT0(12|15|25)|(32|50)0LM0(10|21)|[34]00LM016)-.*",
    "", "", ""
  },
  { "Seagate Laptop SSHD", // tested with ST500LM000-1EJ162/SM11
    "ST(500|1000)LM0(00|14)-.*",
    "", "", ""
  },
  { "Seagate Medalist 1010, 1720, 1721, 2120, 3230 and 4340",  // ATA2, with -t permissive
    "ST3(1010|1720|1721|2120|3230|4340)A",
    "", "", ""
  },
  { "Seagate Medalist 2110, 3221, 4321, 6531, and 8641",
    "ST3(2110|3221|4321|6531|8641)A",
    "", "", ""
  },
  { "Seagate U4",
    "ST3(2112|4311|6421|8421)A",
    "", "", ""
  },
  { "Seagate U5",
    "ST3(40823|30621|20413|15311|10211)A",
    "", "", ""
  },
  { "Seagate U6",
    "ST3(8002|6002|4081|3061|2041)0A",
    "", "", ""
  },
  { "Seagate U7",
    "ST3(30012|40012|60012|80022|120020)A",
    "", "", ""
  },
  { "Seagate U8",
    "ST3(4313|6811|8410|4313|13021|17221)A",
    "", "", ""
  },
  { "Seagate U9", // tested with ST3160022ACE/9.51
    "ST3(80012|120025|160022)A(CE)?",
    "", "", ""
  },
  { "Seagate U10",
    "ST3(20423|15323|10212)A",
    "", "", ""
  },
  { "Seagate UX",
    "ST3(10014A(CE)?|20014A)",
    "", "", ""
  },
  { "Seagate Barracuda ATA",
    "ST3(2804|2724|2043|1362|1022|681)0A",
    "", "", ""
  },
  { "Seagate Barracuda ATA II",
    "ST3(3063|2042|1532|1021)0A",
    "", "", ""
  },
  { "Seagate Barracuda ATA III",
    "ST3(40824|30620|20414|15310|10215)A",
    "", "", ""
  },
  { "Seagate Barracuda ATA IV",
    "ST3(20011|30011|40016|60021|80021)A",
    "", "", ""
  },
  { "Seagate Barracuda ATA V",
    "ST3(12002(3A|4A|9A|3AS)|800(23A|15A|23AS)|60(015A|210A)|40017A)",
    "", "", ""
  },
  { "Seagate Barracuda 5400.1",
    "ST340015A",
    "", "", ""
  },
  { "Seagate Barracuda 7200.7 and 7200.7 Plus", // tested with "ST380819AS          39M3701 39M0171 IBM"/3.03
    "ST3(200021A|200822AS?|16002[13]AS?|12002[26]AS?|1[26]082[78]AS|8001[13]AS?|8081[79]AS|60014A|40111AS|40014AS?)( .* IBM)?",
    "", "", ""
  },
  { "Seagate Barracuda 7200.8",
    "ST3(400[68]32|300[68]31|250[68]23|200826)AS?",
    "", "", ""
  },
  { "Seagate Barracuda 7200.9",
    "ST3(402111?|80[28]110?|120[28]1[0134]|160[28]1[012]|200827|250[68]24|300[68]22|(320|400)[68]33|500[68](32|41))AS?.*",
    "", "", ""
  },
  { "Seagate Barracuda 7200.10",
    "ST3((80|160)[28]15|200820|250[34]10|(250|300|320|400)[68]20|360320|500[68]30|750[68]40)AS?",
    "", "", ""
  },
  { "Seagate Barracuda 7200.11", // unaffected firmware
    "ST3(160813|320[68]13|500[368]20|640[36]23|640[35]30|750[36]30|1000(333|[36]40)|1500341)AS?",
    "CC.?.?", // http://knowledge.seagate.com/articles/en_US/FAQ/207957en
    "", ""
  },
  { "Seagate Barracuda 7200.11", // fixed firmware
    "ST3(500[368]20|750[36]30|1000340)AS?",
    "SD1A", // http://knowledge.seagate.com/articles/en_US/FAQ/207951en
    "", ""
  },
  { "Seagate Barracuda 7200.11", // fixed firmware
    "ST3(160813|320[68]13|640[36]23|1000333|1500341)AS?",
    "SD[12]B", // http://knowledge.seagate.com/articles/en_US/FAQ/207957en
    "", ""
  },
  { "Seagate Barracuda 7200.11", // buggy or fixed firmware
    "ST3(500[368]20|640[35]30|750[36]30|1000340)AS?",
    "(AD14|SD1[5-9]|SD81)",
    "There are known problems with these drives,\n"
    "THIS DRIVE MAY OR MAY NOT BE AFFECTED,\n"
    "see the following web pages for details:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207951en\n"
    "http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=632758",
    ""
  },
  { "Seagate Barracuda 7200.11", // unknown firmware
    "ST3(160813|320[68]13|500[368]20|640[36]23|640[35]30|750[36]30|1000(333|[36]40)|1500341)AS?",
    "",
    "There are known problems with these drives,\n"
    "see the following Seagate web pages:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207951en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207957en",
    ""
  },
  { "Seagate Barracuda 7200.12", // new firmware
    "ST3(160318|250318|320418|50041[08]|750528|1000528)AS",
    "CC4[9A-Z]",
    "", ""
  },
  { "Seagate Barracuda 7200.12", // unknown firmware
    "ST3(160318|250318|320418|50041[08]|750528|1000528)AS",
    "",
    "A firmware update for this drive may be available,\n"
    "see the following Seagate web pages:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/213891en",
    ""
  },
  { "Seagate Barracuda 7200.12", // tested with ST3250312AS/JC45, ST31000524AS/JC45,
      // ST3500413AS/JC4B, ST3750525AS/JC4B
      // ST3160316AS/JC45
      // Possible options: ST31000524AS, ST3500413AS, ST3250312AS ,
      // ST3750525AS, ST3320413AS, ST3160316AS
    "ST3(160318|25031[128]|320418|50041[038]|750(518|52[358])|100052[348]|320413|160316)AS",
    "", "", ""
  },
  { "Seagate Barracuda XT", // tested with ST32000641AS/CC13,
      // ST4000DX000-1C5160/CC42
    "ST(3(2000641|3000651)AS|4000DX000-.*)",
    "", "", ""
  },
  { "Seagate Barracuda 7200.14 (AF)", // new firmware, tested with
      // ST3000DM001-9YN166/CC4H, ST3000DM001-9YN166/CC9E
    "ST(1000|1500|2000|2500|3000)DM00[1-3]-9YN16.",
    "CC(4[H-Z]|[5-9A-Z]..*)", // >= "CC4H"
    "",
    "-v 188,raw16 -v 240,msec24hour32" // tested with ST3000DM001-9YN166/CC4H
  },
  { "Seagate Barracuda 7200.14 (AF)", // old firmware, tested with
      // ST1000DM003-9YN162/CC46
    "ST(1000|1500|2000|2500|3000)DM00[1-3]-9YN16.",
    "CC4[679CG]",
    "A firmware update for this drive is available,\n"
    "see the following Seagate web pages:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/223651en",
    "-v 188,raw16 -v 240,msec24hour32"
  },
  { "Seagate Barracuda 7200.14 (AF)", // unknown firmware
    "ST(1000|1500|2000|2500|3000)DM00[1-3]-9YN16.",
    "",
    "A firmware update for this drive may be available,\n"
    "see the following Seagate web pages:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/223651en",
    "-v 188,raw16 -v 240,msec24hour32"
  },
  { "Seagate Barracuda 7200.14 (AF)", // different part number, tested with
      // ST1000DM003-1CH162/CC47, ST1000DM003-1CH162/CC49, ST2000DM001-1CH164/CC24,
      // ST1000DM000-9TS15E/CC92, APPLE HDD ST3000DM001/AP15 (no attr 240)
    "ST(1000|1500|2000|2500|3000)DM00[0-3]-.*|"
    "APPLE HDD ST3000DM001",
    "", "",
    "-v 188,raw16 -v 240,msec24hour32"
  },
  // should be ST4000DM005, ST3000DM008,ST3000DM009,ST2000DM006,ST2000DM007
  // ST1000DM010, ST500DM009
  // tested: ST3000DM008-2DM166/CC26
  { "Seagate Barracuda 3.5", // tested on ST1000DM010-2EP102/Z9ACZM97
    "ST(4000DM00[45]|3000DM008|3000DM009|2000DM006|2000DM007|1000DM010|500DM009)-.*",
    "", "",
    "-v 188,raw16 -v 240,msec24hour32"
  },
  { "Seagate Barracuda 7200.14 (AF)", // < 1TB, tested with ST250DM000-1BC141
    "ST(250|320|500|750)DM00[0-3]-.*",
    "", "",
    "-v 188,raw16 -v 240,msec24hour32"
  },
  { "Seagate Desktop HDD.15", // tested with ST4000DM000-1CD168/CC43, ST5000DM000-1FK178/CC44,
      // ST6000DM001-1XY17Z/CC48
    "ST[4568]000DM00[012]-.*",
    "", "",
    "-v 188,raw16 -v 240,msec24hour32"
  },
  { "Seagate Desktop SSHD", // tested with ST2000DX001-1CM164/CC43
    "ST[124]000DX001-.*",
    "", "",
    "-v 188,raw16 -v 240,msec24hour32"
  },
  { "Seagate Barracuda LP", // new firmware
    "ST3(500412|1000520|1500541|2000542)AS",
    "CC3[5-9A-Z]",
    "",
    "" // -F xerrorlba ?
  },
  { "Seagate Barracuda LP", // unknown firmware
    "ST3(500412|1000520|1500541|2000542)AS",
    "",
    "A firmware update for this drive may be available,\n"
    "see the following Seagate web pages:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/213915en",
    "-F xerrorlba" // tested with ST31000520AS/CC32
  },
  { "Seagate Barracuda Green (AF)", // new firmware
    "ST((10|15|20)00DL00[123])-.*",
    "CC(3[2-9A-Z]|[4-9A-Z]..*)", // >= "CC32"
    "", ""
  },
  { "Seagate Barracuda Green (AF)", // unknown firmware
    "ST((10|15|20)00DL00[123])-.*",
    "",
    "A firmware update for this drive may be available,\n"
    "see the following Seagate web pages:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/218171en",
    ""
  },
  { "Seagate Barracuda ES",
    "ST3(250[68]2|32062|40062|50063|75064)0NS",
    "", "", ""
  },
  // ST5000LM000, ST4000LM024, ST3000LM024, ST2000LM015, ST1000LM048, ST500LM030
  { "Seagate Barracuda 2.5 5400", // ST2000LM015-2E8174/SDM1, ST4000LM024-2AN17V/0001
    "ST(5000LM000|[34]000LM024|2000LM015|1000LM048|500LM030)-.*",
    "",
    "",
    "-v 183,raw48,SATA_Downshift_Count "
  },
  { "Seagate Barracuda ES.2", // fixed firmware
    "ST3(25031|50032|75033|100034)0NS",
    "SN[01]6|"         // http://knowledge.seagate.com/articles/en_US/FAQ/207963en
    "MA(0[^7]|[^0].)", // http://dellfirmware.seagate.com/dell_firmware/DellFirmwareRequest.jsp
    "",
    "-F xerrorlba" // tested with ST31000340NS/SN06
  },
  { "Seagate Barracuda ES.2", // buggy firmware (Dell)
    "ST3(25031|50032|75033|100034)0NS",
    "MA07",
    "There are known problems with these drives,\n"
    "AND THIS FIRMWARE VERSION IS AFFECTED,\n"
    "see the following Seagate web page:\n"
    "http://dellfirmware.seagate.com/dell_firmware/DellFirmwareRequest.jsp",
    ""
  },
  { "Seagate Barracuda ES.2", // unknown firmware
    "ST3(25031|50032|75033|100034)0NS",
    "",
    "There are known problems with these drives,\n"
    "see the following Seagate web pages:\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207931en\n"
    "http://knowledge.seagate.com/articles/en_US/FAQ/207963en",
    ""
  },
  { "Seagate Constellation (SATA)", // tested with ST9500530NS/SN03
    "ST9(160511|500530)NS",
    "", "", ""
  },
  { "Seagate Constellation ES (SATA)", // tested with ST31000524NS/SN11,
      // MB0500EAMZD/HPG1
    "ST3(50051|100052|200064)4NS|"
    "MB0500EAMZD", // HP OEM
    "", "", ""
  },
  { "Seagate Constellation ES (SATA 6Gb/s)", // tested with ST1000NM0011/SN02,
      // MB1000GCEEK/HPG1
    "ST(5|10|20)00NM0011|"
    "MB1000GCEEK", // HP OEM
    "", "", ""
  },
  { "Seagate Constellation ES.2 (SATA 6Gb/s)", // tested with ST32000645NS/0004, ST33000650NS,
      // MB3000EBKAB/HPG6
    "ST3(2000645|300065[012])NS|"
    "MB3000EBKAB", // HP OEM
    "", "", ""
  },
  { "Seagate Constellation ES.3", // tested with ST1000NM0033-9ZM173/0001,
      // ST4000NM0033-9ZM170/SN03, MB1000GCWCV/HPGC
    "ST[1234]000NM00[35]3-.*|"
    "MB1000GCWCV", // HP OEM
    "", "", ""
  },
  { "Seagate Constellation CS", // tested with ST3000NC000/CE02, ST3000NC002-1DY166/CN02
    "ST(1000|2000|3000)NC00[0-3](-.*)?",
    "", "", ""
  },
  { "Seagate Constellation.2 (SATA)", // 2.5", tested with ST91000640NS/SN02, MM1000GBKAL/HPGB
    "ST9(25061|50062|100064)[012]NS|" // *SS = SAS
    "MM1000GBKAL", // HP OEM
    "", "", ""
  },
  // ST6000NM0004, ST6000NM0024, ST6000NM0044, ST6000NM0084, ST5000NM0024,
  // ST5000NM0044, ST4000NM0024, ST4000NM0044, ST2000NM0024, ST2000NM0044
  // ST4000NM0035, ST3000NM0005, ST2000NM0055, ST1000NM0055, ST4000NM0045,
  // ST3000NM0015, ST2000NM0065, ST1000NM0065, ST4000NM0105, ST3000NM0055
  { "Seagate Enterprise Capacity 3.5 HDD", // tested with ST6000NM0024-1HT17Z/SN02,
      // ST10000NM0016-1TT101/SNB0
      // ST4000NM0085-1YY107/ZC11SXPH
      // ST8000NM0045-1RL112/NN02
      // ST6000NM0004-1FT17Z/NN01
      // ST4000NM0035-1V4107/TNC3
    "ST([24568]|10)000NM0[01][0-48][456]-.*", // *[069]4 = 4Kn
    "", "", 
    "-v 188,raw16 -v 240,msec24hour32"
  },
  // new models: ST8000VN0002, ST6000VN0021, ST4000VN000
  //             ST8000VN0012, ST6000VN0031, ST4000VN003
  // tested with ST8000VN0002-1Z8112/ZA13YGNF
  { "Seagate NAS HDD", // tested with ST2000VN000-1H3164/SC42, ST3000VN000-1H4167/SC43
    "ST([234]000VN000|[468]000VN00(02|21|12|31|3))-.*",
    "", "", ""
  },
  // ST10000VN0004, ST8000VN0022, ST6000VN0041, ST4000VN008, ST3000VN007,
  // ST2000VN004, ST1000VN002
  { "Seagate IronWolf", // tested with ST6000VN0041-2EL11C/SC61
    "ST(10|8|6|4|3|2|1)000VN00(04|22|41|8|7|2|4)-.*",
    "", "", ""
  },  
  { "Seagate Archive HDD", // tested with ST8000AS0002-1NA17Z/AR13
    "ST[568]000AS00[01][12]-.*",
    "", "", ""
  },
  { "Seagate Pipeline HD 5900.1",
    "ST3(160310|320[34]10|500(321|422))CS",
    "", "", ""
  },
  { "Seagate Pipeline HD 5900.2", // tested with ST31000322CS/SC13
    "ST3(160316|250[34]12|320(311|413)|500(312|414)|1000(322|424))CS",
    "", "", ""
  },
  { "Seagate Video 3.5 HDD", // tested with ST4000VM000-1F3168/SC23, SC25
    "ST(10|15|20|30|40)00VM00[023]-.*",
    "", "", ""
  },
  { "Seagate Medalist 17240, 13030, 10231, 8420, and 4310",
    "ST3(17240|13030|10231|8420|4310)A",
    "", "", ""
  },
  { "Seagate Medalist 17242, 13032, 10232, 8422, and 4312",
    "ST3(1724|1303|1023|842|431)2A",
    "", "", ""
  },
  { "Seagate NL35",
    "ST3(250623|250823|400632|400832|250824|250624|400633|400833|500641|500841)NS",
    "", "", ""
  },
  { "Seagate SV35.2",
    "ST3(160815|250820|320620|500630|750640)[AS]V",
    "", "", ""
  },
  { "Seagate SV35.3", // tested with ST3500320SV/SV16
    "ST3(500320|750330|1000340)SV",
    "", "", ""
  },
  { "Seagate SV35.5", // tested with ST31000525SV/CV12
    "ST3(250311|500410|1000525)SV",
    "", "", ""
  },
  // ST6000VX0001,ST6000VX0011,ST5000VX0001,ST5000VX0011,ST4000VX000
  // ST4000VX002, ST3000VX002, ST2000VX003, ST1000VX001, ST1000VX002
  // ST3000VX000, ST3000VX004, ST2000VX000, ST2000VX004, ST1000VX000
  { "Seagate Surveillance", // tested with ST1000VX001-1HH162/CV11, ST2000VX000-9YW164/CV12,
      // ST4000VX000-1F4168/CV14, ST2000VX003-1HH164/CV12
    "ST([1-6]000VX00[01234]1?|31000526SV|3500411SV)(-.*)?",
    "", "", ""
  },
  { "Seagate DB35", // tested with ST3250823ACE/3.03, ST3300831SCE/3.03
    "ST3(200826|250823|300831|400832)[AS]CE",
    "", "", ""
  },
  { "Seagate DB35.2", // tested with ST3160212SCE/3.ACB
    "ST3(802110|120213|160212|200827|250824|300822|400833|500841)[AS]CE",
    "", "", ""
  },
  { "Seagate DB35.3",
    "ST3(750640SCE|((80|160)215|(250|320|400)820|500830|750840)[AS]CE)",
    "", "", ""
  },
  { "Seagate LD25.2", // tested with ST940210AS/3.ALC
    "ST9(40|80)210AS?",
    "", "", ""
  },
  { "Seagate ST1.2 CompactFlash", // tested with ST68022CF/3.01
    "ST6[468]022CF",
    "", "", ""
  },
  { "WD Blue PC SSD", // tested with WDC WDS100T1B0A-00H9H0
    "WDC WDS...[TG]1B0[AB].*",
    "", "",
  //"-v 5,raw48,Reallocated_Sector_Ct " // Reassigned Block Count
  //"-v 9,raw48,Power_On_Hours "
  //"-v 12,raw48,Power_Cycle_Count "
    "-v 165,raw48,Block_Erase_Count "
    "-v 166,raw48,Minimum_PE_Cycles_TLC "
    "-v 167,raw48,Max_Bad_Blocks_per_Die "
    "-v 168,raw48,Maximum_PE_Cycles_TLC "
    "-v 169,raw48,Total_Bad_Blocks "
    "-v 170,raw48,Grown_Bad_Blocks "
    "-v 171,raw48,Program_Fail_Count "
    "-v 172,raw48,Erase_Fail_Count "
    "-v 173,raw48,Average_PE_Cycles_TLC "
    "-v 174,raw48,Unexpected_Power_Loss "
  //"-v 184,raw48,End-to-end_Error " // Detection/Correction Count
  //"-v 187,raw48,Reported_Uncorrect " // Uncorrectable Errors
  //"-v 188,raw48,Command_Timeout
  //"-v 194,tempminmax,Temperature_Celsius " 
  //"-v 199,raw48,UDMA_CRC_Error_Count  // SATA CRC Errors 
    "-v 230,hex48,Media_Wearout_Indicator " // Maybe hex16
  //"-v 232,raw48,Available_Reserve_Space"
    "-v 233,raw48,NAND_GB_Written_TLC "
    "-v 234,raw48,NAND_GB_Written_SLC "
    "-v 241,raw48,Total_Host_GB_Written "
    "-v 242,raw48,Total_Host_GB_Read "
    "-v 244,raw48,Temp_Throttle_Status "
  },
  { "Western Digital Protege",
  /* Western Digital drives with this comment all appear to use Attribute 9 in
   * a  non-standard manner.  These entries may need to be updated when it
   * is understood exactly how Attribute 9 should be interpreted.
   * UPDATE: this is probably explained by the WD firmware bug described in the
   * smartmontools FAQ */
    "WDC WD([2468]00E|1[26]00A)B-.*",
    "", "", ""
  },
  { "Western Digital Caviar",
  /* Western Digital drives with this comment all appear to use Attribute 9 in
   * a  non-standard manner.  These entries may need to be updated when it
   * is understood exactly how Attribute 9 should be interpreted.
   * UPDATE: this is probably explained by the WD firmware bug described in the
   * smartmontools FAQ */
    "WDC WD(2|3|4|6|8|10|12|16|18|20|25)00BB-.*",
    "", "", ""
  },
  { "Western Digital Caviar WDxxxAB",
  /* Western Digital drives with this comment all appear to use Attribute 9 in
   * a  non-standard manner.  These entries may need to be updated when it
   * is understood exactly how Attribute 9 should be interpreted.
   * UPDATE: this is probably explained by the WD firmware bug described in the
   * smartmontools FAQ */
    "WDC WD(3|4|6|8|25)00AB-.*",
    "", "", ""
  },
  { "Western Digital Caviar WDxxxAA",
  /* Western Digital drives with this comment all appear to use Attribute 9 in
   * a  non-standard manner.  These entries may need to be updated when it
   * is understood exactly how Attribute 9 should be interpreted.
   * UPDATE: this is probably explained by the WD firmware bug described in the
   * smartmontools FAQ */
    "WDC WD...?AA(-.*)?",
    "", "", ""
  },
  { "Western Digital Caviar WDxxxBA",
  /* Western Digital drives with this comment all appear to use Attribute 9 in
   * a  non-standard manner.  These entries may need to be updated when it
   * is understood exactly how Attribute 9 should be interpreted.
   * UPDATE: this is probably explained by the WD firmware bug described in the
   * smartmontools FAQ */
    "WDC WD...BA",
    "", "", ""
  },
  { "Western Digital Caviar AC", // add only 5400rpm/7200rpm (ata33 and faster)
    "WDC AC((116|121|125|225|132|232)|([1-4][4-9][0-9])|([1-4][0-9][0-9][0-9]))00[A-Z]?.*",
    "", "", ""
  },
  { "Western Digital Caviar SE",
  /* Western Digital drives with this comment all appear to use Attribute 9 in
   * a  non-standard manner.  These entries may need to be updated when it
   * is understood exactly how Attribute 9 should be interpreted.
   * UPDATE: this is probably explained by the WD firmware bug described in the
   * smartmontools FAQ
   * UPDATE 2: this does not apply to more recent models, at least WD3200AAJB */
    "WDC WD(4|6|8|10|12|16|18|20|25|30|32|40|50)00(JB|PB)-.*",
    "", "", ""
  },
  { "Western Digital Caviar Blue EIDE",  // WD Caviar SE EIDE
    /* not completely accurate: at least also WD800JB, WD(4|8|20|25)00BB sold as Caviar Blue */
    "WDC WD(16|25|32|40|50)00AAJB-.*",
    "", "", ""
  },
  { "Western Digital Caviar Blue EIDE",  // WD Caviar SE16 EIDE
    "WDC WD(25|32|40|50)00AAKB-.*",
    "", "", ""
  },
  { "Western Digital RE EIDE",
    "WDC WD(12|16|25|32)00SB-.*",
    "", "", ""
  },
  { "Western Digital Caviar Serial ATA",
    "WDC WD(4|8|20|32)00BD-.*",
    "", "", ""
  },
  { "Western Digital Caviar SE Serial ATA", // tested with WDC WD3000JD-98KLB0/08.05J08
    "WDC WD(4|8|12|16|20|25|30|32|40)00(JD|KD|PD)-.*",
    "", "", ""
  },
  { "Western Digital Caviar SE Serial ATA",
    "WDC WD(8|12|16|20|25|30|32|40|50)00JS-.*",
    "", "", ""
  },
  { "Western Digital Caviar SE16 Serial ATA",
    "WDC WD(16|20|25|32|40|50|75)00KS-.*",
    "", "", ""
  },
  { "Western Digital Caviar Blue Serial ATA",  // WD Caviar SE Serial ATA
    /* not completely accurate: at least also WD800BD, (4|8)00JD sold as Caviar Blue */
    "WDC WD((8|12|16|25|32)00AABS|(8|12|16|25|32|40|50)00AAJS)-.*",
    "", "", ""
  },
  { "Western Digital Caviar Blue (SATA)",  // WD Caviar SE16 Serial ATA
      // tested with WD1602ABKS-18N8A0/DELL/02.03B04
    "WDC WD((16|20|25|32|40|50|64|75)00AAKS|1602ABKS|10EALS)-.*",
    "", "", ""
  },
  { "Western Digital Blue", // tested with WDC WD5000AZLX-00K4KA0/80.00A80,
      // WDC WD10EZEX-00RKKA0/80.00A80, WDC WD10EZEX-75M2NA0/01.01A01, WDC WD40EZRZ-00WN9B0/80.00A80
    "WDC WD((25|32|50)00AAKX|5000AZ(LX|RZ)|7500A(AL|ZE)X|10E(AL|ZE)X|[1-6]0EZRZ)-.*",
    "", "", ""
  },
  { "Western Digital RE Serial ATA",
    "WDC WD(12|16|25|32)00(SD|YD|YS)-.*",
    "", "", ""
  },
  { "Western Digital RE2 Serial ATA",
    "WDC WD((40|50|75)00(YR|YS|AYYS)|(16|32|40|50)0[01]ABYS)-.*",
    "", "", ""
  },
  { "Western Digital RE2-GP",
    "WDC WD(5000AB|7500AY|1000FY)PS-.*",
    "", "", ""
  },
  { "Western Digital RE3 Serial ATA", // tested with WDC WD7502ABYS-02A6B0/03.00C06
    "WDC WD((25|32|50|75)02A|(75|10)02F)BYS-.*",
    "", "", ""
  },
  { "Western Digital RE4", // tested with WDC WD2003FYYS-18W0B0/01.01D02,
      // WDC WD1003FBYZ-010FB0/01.01V03
      // WDC WD5003ABYZ-011FA0/01.01S03
    "WDC WD((25|50)03ABY[XZ]|1003FBY[XZ]|(15|20)03FYYS)-.*",
    "", "", ""
  },
  { "Western Digital RE4-GP", // tested with WDC WD2002FYPS-02W3B0/04.01G01,
      // WD2003FYPS-27W9B0/01.01D02
    "(WDC )?WD200[23]FYPS-.*",
    "", "", ""
  },
  { "Western Digital Re", // tested with WDC WD1004FBYZ-01YCBB0/RR02,
      // WDC WD2000FYYZ-01UL1B0/01.01K01, WDC WD2000FYYZ-01UL1B1/01.01K02,
      // WDC WD4000FYYZ-01UL1B2/01.01K03, WD2000FYYX/00.0D1K2,
      // WDC WD1004FBYZ-01YCBB1/RR04
    "WDC WD([12]004FBYZ|[1-6]00[01M]F[SXY]YZ)-.*|WD2000FYYX",
    "", "",
    "-v 16,raw48,Total_LBAs_Read" // WDC WD1004FBYZ-01YCBB1/RR04
  },
  { "Western Digital Se", // tested with WDC WD2000F9YZ-09N20L0/01.01A01
    "WDC WD(1002|2000|3000|4000)F9YZ-.*",
    "", "", ""
  },
  { "Western Digital Caviar Green", // tested with WDC WD7500AADS-00M2B0/01.00A01,
       // WDC WD10EADX/77.04D77
    "WDC WD((50|64|75)00AA[CV]S|(50|64|75)00AADS|10EA[CV]S|(10|15|20)EAD[SX])-.*",
    "",
    "",
    "-F xerrorlba" // tested with WDC WD7500AADS-00M2B0/01.00A01
  },
  { "Western Digital Caviar Green (AF)",
    "WDC WD(((64|75|80)00AA|(10|15|20)EA|(25|30)EZ)R|20EAC)S-.*",
    "", "", ""
  },
  { "Western Digital Green", // tested with
      // WDC WD10EZRX-00A8LB0/01.01A01, WDC WD20EZRX-00DC0B0/80.00A80,
      // WDC WD30EZRX-00MMMB0/80.00A80, WDC WD40EZRX-00SPEB0/80.00A80,
      // WDC WD60EZRX-00MVLB1/80.00A80
    "WDC WD(7500AA|(10|15|20)EA|(10|20|25|30|40|50|60)EZ)RX-.*",
    "", "", ""
  },
  { "Western Digital Caviar Black", // tested with WDC WD7501AAES/06.01D06
    "WDC WD((500|640)1AAL|7501AA[EL]|1001FA[EL]|2001FAS)S-.*|"
    "WDC WD(2002|7502|1502|5003|1002|5002)(FAE|AAE|AZE|AAL)X-.*", // could be
    // WD2002FAEX, WD7502AAEX, WD1502FAEX, WD5003AZEX, WD1002FAEX, WD5002AALX
    "", "", ""
  },
  { "Western Digital Black", // tested with
      // WDC WD1003FZEX-00MK2A0/01.01A01, WDC WD3001FAEX-00MJRA0/01.01L01,
      // WDC WD3003FZEX-00Z4SA0/01.01A01, WDC WD4001FAEX-00MJRA0/01.01L01
      // WDC WD4003FZEX-00Z4SA0/01.01A01, WDC WD5003AZEX-00RKKA0/80.00A80,
      // WDC WD4004FZWX-00GBGB0/81.H0A81
    "WDC WD(6001|2003|5001|1003|4003|4004|5003|3003|3001)(FZW|FZE|AZE)X-.*|" // could be
    // new series  WD6001FZWX WD2003FZEX WD5001FZWX WD1003FZEX
    //             WD4003FZEX WD5003AZEX WD3003FZEX WD4004FZWX
    "WDC WD(4001|3001|2002|1002|5003|7500|5000|3200|2500|1600)(FAE|AZE)X-.*",
    // old series: WD4001FAEX WD3001FAEX WD2002FAEX WD1002FAEX  WD5003AZEX
    "", "", ""
  },
  { "Western Digital AV ATA", // tested with WDC WD3200AVJB-63J5A0/01.03E01
    "WDC WD(8|16|25|32|50)00AV[BJ]B-.*",
    "", "", ""
  },
  { "Western Digital AV SATA",
    "WDC WD(16|25|32)00AVJS-.*",
    "", "", ""
  },
  { "Western Digital AV-GP",
    "WDC WD((16|25|32|50|64|75)00AV[CDV]S|(10|15|20)EV[CDV]S)-.*",
    "", "", ""
  },
  { "Western Digital AV-GP (AF)", // tested with WDC WD10EURS-630AB1/80.00A80,
      // WDC WD10EUCX-63YZ1Y0/51.0AB52, WDC WD20EURX-64HYZY0/80.00A80
    "WDC WD(5000AUDX|7500AURS|10EUCX|(10|15|20|25|30)EUR[SX])-.*",
    "", "", ""
  },
  { "Western Digital AV", // tested with DC WD10JUCT-63CYNY0/01.01A01
    "WDC WD((16|25|32|50)00BU[CD]|5000LUC|10JUC)T-.*",
    "", "", ""
  },
  { "Western Digital Raptor",
    "WDC WD((360|740|800)GD|(360|740|800|1500)ADF[DS])-.*",
    "", "", ""
  },
  { "Western Digital Raptor X",
    "WDC WD1500AHFD-.*",
    "", "", ""
  },
  { "Western Digital VelociRaptor", // tested with WDC WD1500HLHX-01JJPV0/04.05G04
    "WDC WD(((800H|(1500|3000)[BH]|1600H|3000G)LFS)|((1500|3000|4500|6000)[BH]LHX))-.*",
    "", "", ""
  },
  { "Western Digital VelociRaptor (AF)", // tested with WDC WD1000DHTZ-04N21V0/04.06A00
    "WDC WD(2500H|5000H|1000D)HTZ-.*",
    "", "", ""
  },
  { "Western Digital Scorpio EIDE",
    "WDC WD(4|6|8|10|12|16)00(UE|VE)-.*",
    "", "", ""
  },
  { "Western Digital Scorpio Blue EIDE", // tested with WDC WD3200BEVE-00A0HT0/11.01A11
    "WDC WD(4|6|8|10|12|16|25|32)00BEVE-.*",
    "", "", ""
  },
  { "Western Digital Scorpio Serial ATA",
    "WDC WD(4|6|8|10|12|16|25)00BEAS-.*",
    "", "", ""
  },
  { "Western Digital Scorpio Blue Serial ATA",
    "WDC WD((4|6|8|10|12|16|25)00BEVS|(8|12|16|25|32|40|50|64)00BEVT|7500KEVT|10TEVT)-.*",
    "", "", ""
  },
  { "Western Digital Scorpio Blue Serial ATA (AF)", // tested with
      // WDC WD10JPVT-00A1YT0/01.01A01
    "WDC WD((16|25|32|50|64|75)00BPVT|10[JT]PVT)-.*",
    "", "", ""
  },
  { "Western Digital Scorpio Black", // tested with WDC WD5000BEKT-00KA9T0/01.01A01
    "WDC WD(8|12|16|25|32|50)00B[EJ]KT-.*",
    "", "", ""
  },
  { "Western Digital Scorpio Black (AF)",
    "WDC WD(50|75)00BPKT-.*",
    "", "", ""
  },
  { "Western Digital Red", // tested with WDC WD10EFRX-68JCSN0/01.01A01,
      // WDC WD10JFCX-68N6GN0/01.01A01, WDC WD40EFRX-68WT0N0/80.00A80,
      // WDC WD60EFRX-68MYMN1/82.00A82, WDC WD80EFAX-68LHPN0/83.H0A83,
      // WDC WD80EFZX-68UW8N0/83.H0A83
    "WDC WD(7500BFC|10JFC|[1-6]0EFR|80EF[AZ])X-.*",
    "", "",
    "-v 22,raw48,Helium_Level" // WD80EFZX
  },
  { "Western Digital Red Pro", // tested with WDC WD2001FFSX-68JNUN0/81.00A81,
      // WDC WD6002FFWX-68TZ4N0/83.H0A83
    "WDC WD([2-68]00[12])FF[SW]X-.*",
    "", "", ""
  },
  { "Western Digital Purple", // tested with WDC WD40PURX-64GVNY0/80.00A80
    "WDC WD[123456]0PURX-.*",
    "", "", ""
  },
  { "Western Digital Gold", // tested with WDC WD4002FYYZ-01B7CB0/01.01M02
    "WDC WD(101KR|[68]002FR|4002FY)YZ-.*",
    "", "", ""
  },
  { "Western Digital Blue Mobile", // tested with WDC WD5000LPVX-08V0TT2/03.01A03,
      // WDC WD20NPVZ-00WFZT0/01.01A01
    "WDC WD((25|32|50|75)00[BLM]|10[JS]|20N)P[CV][TXZ]-.*",
    "", "", ""
  },
  { "Western Digital Green Mobile", // tested with WDC WD20NPVX-00EA4T0/01.01A01
    "WDC WD(15|20)NPV[TX]-.*",
    "", "", ""
  },
  { "Western Digital Black Mobile", // tested with WDC WD7500BPKX-22HPJT0/01.01A01,
      // WDC WD10JPLX-00MBPT0/01.01H01
    "WDC WD((16|25|32)00BEK[TX]|(25|32|50|75)00(BPK|LPL)X|10JPLX)-.*",
    "", "", ""
  },
  { "Western Digital Elements / My Passport (USB)", // tested with WDC WD5000BMVW-11AMCS0/01.01A01
    "WDC WD(25|32|40|50)00BMV[UVW]-.*",  // *W-* = USB 3.0
    "", "", ""
  },
  { "Western Digital Elements / My Passport (USB, AF)", // tested with
      // WDC WD5000KMVV-11TK7S1/01.01A01,
      // WDC WD5000LMVW-11CKRS0/01.01A01 (0x1058:0x07ae),
      // WDC WD5000LMVW-11VEDS0/01.01A01 (0x1058:0x0816),
      // WDC WD7500BMVW-11AJGS2/01.01A01,
      // WDC WD10JMVW-11AJGS2/01.01A01 (0x1058:0x10b8),
      // WDC WD10JMVW-11AJGS4/01.01A01 (0x1058:0x25a2),
      // WDC WD10JMVW-11S5XS1/01.01A01,
      // WDC WD10TMVW-11ZSMS5/01.01A01,
      // WDC WD20NMVW-11AV3S2/01.01A01 (0x1058:0x0822),
      // WDC WD20NMVW-11AV3S3/01.01A01 (0x1058:0x0837),
      // WDC WD20NMVW-11EDZS6/01.01A01 (0x1058-0x259f),
      // WDC WD20NMVW-11EDZS7/01.01A01 (0x1058:0x259d/25a1),
      // WDC WD20NMVW-11W68S0/01.01A01,
      // WDC WD20NMVW-59AV3S3/01.01A01 (0x1058:0x107d),
      // WDC WD30NMVW-11C3NS4/01.01A01,
      // WDC WD40NMZW-11GX6S1/01.01A01 (0x1058:0x2599/25e2/25fa)
    "WDC WD(5000[LK]|7500[BK]|10[JT]|[234]0N)M[VZ][VW]-.*", // *W-* = USB 3.0
    "", "", ""
  },
  { "Quantum Bigfoot", // tested with TS10.0A/A21.0G00, TS12.7A/A21.0F00
    "QUANTUM BIGFOOT TS(10\\.0|12\\.7)A",
    "", "", ""
  },
  { "Quantum Fireball lct15",
    "QUANTUM FIREBALLlct15 ([123]0|22)",
    "", "", ""
  },
  { "Quantum Fireball lct20",
    "QUANTUM FIREBALLlct20 [1234]0",
    "", "", ""
  },
  { "Quantum Fireball CX",
    "QUANTUM FIREBALL CX10.2A",
    "", "", ""
  },
  { "Quantum Fireball CR",
    "QUANTUM FIREBALL CR(4.3|6.4|8.4|13.0)A",
    "", "", ""
  },
  { "Quantum Fireball EX", // tested with QUANTUM FIREBALL EX10.2A/A0A.0D00
    "QUANTUM FIREBALL EX(3\\.2|6\\.4|10\\.2)A",
    "", "", ""
  },
  { "Quantum Fireball ST",
    "QUANTUM FIREBALL ST(3.2|4.3|4300)A",
    "", "", ""
  },
  { "Quantum Fireball SE",
    "QUANTUM FIREBALL SE4.3A",
    "", "", ""
  },
  { "Quantum Fireball Plus LM",
    "QUANTUM FIREBALLP LM(10.2|15|20.[45]|30)",
    "", "", ""
  },
  { "Quantum Fireball Plus AS",
    "QUANTUM FIREBALLP AS(10.2|20.5|30.0|40.0|60.0)",
    "", "", ""
  },
  { "Quantum Fireball Plus KX",
    "QUANTUM FIREBALLP KX27.3",
    "", "", ""
  },
  { "Quantum Fireball Plus KA",
    "QUANTUM FIREBALLP KA(9|10).1",
    "", "", ""
  },

  ////////////////////////////////////////////////////
  // USB ID entries
  ////////////////////////////////////////////////////

  // 0x0350 (?)
  { "USB: ViPowER USB3.0 Storage; ",
    "0x0350:0x0038",
    "", // 0x1905
    "",
    "-d sat,12" // ATA output registers missing
  },
  // Hewlett-Packard
  { "USB: HP Desktop HD BD07; ", // 2TB
    "0x03f0:0xbd07",
    "",
    "",
    "-d sat"
  },
  // ALi
  { "USB: ; ALi M5621", // USB->PATA
    "0x0402:0x5621",
    "",
    "",
    "" // unsupported
  },
  // VIA
  { "USB: Connectland BE-USB2-35BP-LCM; VIA VT6204",
    "0x040d:0x6204",
    "",
    "",
    "" // unsupported
  },
  // Buffalo / Melco
  { "USB: Buffalo JustStore Portable HD-PVU2; ",
    "0x0411:0x0181",
    "",
    "",
    "-d sat"
  },
  { "USB: Buffalo Drivestation Duo; ",
    "0x0411:0x01ce",
    "",
    "",
    "-d sat"
  },
  { "USB: Buffalo DriveStation HD-LBU2 ; Medialogic MLDU11",
    "0x0411:0x01ea",
    "",
    "",
    "-d sat"
  },
  { "USB: Buffalo MiniStation; ",
    "0x0411:0x0(1[df]9|240|251)", // 0x01d9: HD-PCTU2 (0x0108),
      // 0x01f9: HD-PZU3 (0x0100), 0x0240: HD-PCFU3, 0x0251: HD-PNFU3
    "",
    "",
    "-d sat"
  },
  // LG Electronics
  { "USB: LG Mini HXD5; JMicron",
    "0x043e:0x70f1",
    "", // 0x0100
    "",
    "-d usbjmicron"
  },
  // Hitachi (?)
  { "USB: ; Renesas uPD720231A", // USB2/3->SATA
    // 0x0229: Pi-102 Raspberry Pi USB to mSATA Converter Board
    // 0x022a: DeLock 62652 converter SATA 6GB/s > USB 3.0
    "0x045b:0x022[9a]",
    "",
    "",
    "-d sat"
  },
  // Philips
  { "USB: Philips; ", // SDE3273FC/97 2.5" SATA HDD enclosure
    "0x0471:0x2021",
    "", // 0x0103
    "",
    "-d sat"
  },
  // Toshiba
  { "USB: Toshiba Stor.E Slim USB 3.0; ", // TOSHIBA MQ01UBD100
    "0x0480:0x0100",
    "", // 0x0000
    "",
    "-d sat"
  },
  { "USB: Toshiba Canvio; ", // 0x0210: TOSHIBA MQ03UBB300
    "0x0480:0x02(01|10)",
    "",
    "",
    "-d sat"
  },
  { "USB: Toshiba Canvio 500GB; SunPlus",
    "0x0480:0xa004",
    "",
    "",
    "-d usbsunplus"
  },
  { "USB: Toshiba Canvio Basics; ",
    "0x0480:0xa00[6d]",
    "", // 0x0001, 0x0407
    "",
    "-d sat"
  },
  { "USB: Toshiba Stor.E; ",
    "0x0480:0xa00[9ace]",
    "", // 0x0000 (0xa00e)
    "",
    "-d sat"
  },
  { "USB: Toshiba Canvio; ",
    "0x0480:0x(a(007|100|20[027c])|" // 0xa007 TOSHIBA MQ01UBD050,
              "b207)", // 0xa100: TOSHIBA MQ01UBB200, 0xa200: TOSHIBA MQ01UBD100,
        // 0xa202: TOSHIBA MQ01UBD050, 0xa207: TOSHIBA MQ01ABD100,
        // 0xa20c: TOSHIBA MQ01ABB200, 0xb207: TOSHIBA MQ03UBB200
    "", // 0x0001 (0xa007)
    "",
    "-d sat"
  },
  { "USB: Toshiba Canvio Desktop; ",
    "0x0480:0xd0(00|10|11)",
    "", // 0x0316 (0xd011)
    "",
    "-d sat"
  },
  // Cypress
  { "USB: ; Cypress CY7C68300A (AT2)",
    "0x04b4:0x6830",
    "0x0001",
    "",
    "" // unsupported
  },
  { "USB: ; Cypress CY7C68300B/C (AT2LP)",
    "0x04b4:0x6830",
    "0x0240",
    "",
    "-d usbcypress"
  },
  // Fujitsu
  { "USB: Fujitsu/Zalman ZM-VE300; ", // USB 3.0
    "0x04c5:0x2028",
    "", // 0x0001
    "",
    "-d sat"
  },
  { "USB: ; Fujitsu", // DeLock 42475, USB 3.0
    "0x04c5:0x201d",
    "", // 0x0001
    "",
    "-d sat"
  },
  // Myson Century
  { "USB: ; Myson Century CS8818",
    "0x04cf:0x8818",
    "", // 0xb007
    "",
    "" // unsupported
  },
  // Samsung
  { "USB: Samsung S2 Portable; JMicron",
    "0x04e8:0x1f0[568a]", // 0x1f0a: SAMSUNG HN-M101XBB
    "",
    "",
    "-d usbjmicron" // 0x1f0a: works also with "-d sat"
  },
  { "USB: Samsung S1 Portable; JMicron",
    "0x04e8:0x2f03",
    "",
    "",
    "-d usbjmicron"
  },
  { "USB: Samsung Story Station; ",
    "0x04e8:0x5f0[56]",
    "",
    "",
    "-d sat"
  },
  { "USB: Samsung G2 Portable; JMicron",
    "0x04e8:0x6032",
    "0x0000",
    "",
    "-d usbjmicron" // ticket #132
  },
  { "USB: Samsung G2 Portable; ",
    "0x04e8:0x6032",
    "0x...[1-9]", // >= 0x0001
    "",
    "-d sat"
  },
  { "USB: Samsung Story Station 3.0; ",
    "0x04e8:0x6052",
    "",
    "",
    "-d sat"
  },
  { "USB: Samsung Story Station 3.0; ",
    "0x04e8:0x6054",
    "",
    "",
    "-d sat"
  },
  { "USB: Samsung M2 Portable 3.0; ",
    "0x04e8:0x60c5",
    "",
    "",
    "-d sat"
  },
  { "USB: Samsung D3 Station; ",
    "0x04e8:0x612[45]", // 3TB, 4TB
    "", // 0x200, 0x202
    "",
    "-d sat"
  },
  { "USB: Samsung M3 Portable USB 3.0; ", // 1.5/2TB: SpinPoint M9TU
    "0x04e8:0x61b[3456]", // 500MB, 2TB, 1.5TB, 1TB
    "", // 0x0e00
    "",
    "-d sat"
  },
  { "USB: Samsung S3 Portable; ",
    "0x04e8:0x61c8", // ST1000LM025 HN-M101ABB
    "", // 0x1301
    "",
    "-d sat"
  },
  // Sunplus
  { "USB: ; SunPlus",
    "0x04fc:0x0c05",
    "",
    "",
    "-d usbsunplus"
  },
  { "USB: ; SunPlus SPDIF215",
    "0x04fc:0x0c15",
    "", // 0xf615
    "",
    "-d usbsunplus"
  },
  { "USB: ; SunPlus SPDIF225", // USB+SATA->SATA
    "0x04fc:0x0c25",
    "", // 0x0103
    "",
    "-d usbsunplus"
  },
  // Iomega
  { "USB: Iomega Prestige Desktop USB 3.0; ",
    "0x059b:0x0070",
    "", // 0x0004
    "",
    "-d sat" // ATA output registers missing
  },
  { "USB: Iomega LPHD080-0; ",
    "0x059b:0x0272",
    "",
    "",
    "-d usbcypress"
  },
  { "USB: Iomega MDHD500-U; ",
    "0x059b:0x0275",
    "", // 0x0001
    "",
    "" // unsupported
  },
  { "USB: Iomega; JMicron",
    "0x059b:0x027[78]",  // 0x0277: MDHD-UE, 0x0278: LDHD-UPS
    "", // 0x0000
    "",
    "-d usbjmicron"
  },
  { "USB: Iomega LDHD-UP; Sunplus",
    "0x059b:0x0370",
    "",
    "",
    "-d usbsunplus"
  },
  { "USB: Iomega; JMicron",
    "0x059b:0x0(47[05]|57[15])", // 0x0470: LPHD-UP, 0x0475: GDHDU2 (0x0100),
      // 0x0575: LDHD-UP
    "",
    "",
    "-d usbjmicron"
  },
  { "USB: Iomega; JMicron",
    "0x059b:0x047a",
    "", // 0x0100
    "",
    "-d sat" // works also with "-d usbjmicron"
  },
  // LaCie
  { "USB: LaCie hard disk (FA Porsche design);",
    "0x059f:0x0651",
    "",
    "",
    "" // unsupported
  },
  { "USB: LaCie d2 Quadra; Oxford OXUF934SSA-LQAG ", // USB+IEEE1394+eSATA->SATA
    "0x059f:0x0828",
    "",
    "",
    "-d sat"
  },
  { "USB: LaCie hard disk; JMicron",
    "0x059f:0x0951",
    "",
    "",
    "-d usbjmicron"
  },
  { "USB: LaCie Rugged Triple Interface; ",
    "0x059f:0x100c",
    "", // 0x0001
    "",
    "-d sat"
  },
  { "USB: LaCie Desktop Hard Drive;",
    "0x059f:0x1010",
    "",
    "",
    "-d usbsunplus"
  },
  { "USB: LaCie Desktop Hard Drive; ",
    "0x059f:0x101[68]", // 0x1016: SAMSUNG HD103UJ
    "", // 0x0001
    "",
    "-d sat"
  },
  { "USB: LaCie Desktop Hard Drive; JMicron",
    "0x059f:0x1019",
    "",
    "",
    "-d usbjmicron"
  },
  { "USB: LaCie Rugged Hard Drive; JMicron",
    "0x059f:0x101d",
    "", // 0x0001
    "",
    "-d usbjmicron,x"
  },
  { "USB: LaCie Little Disk USB2; JMicron",
    "0x059f:0x1021",
    "",
    "",
    "-d usbjmicron"
  },
  { "USB: LaCie hard disk; ",
    "0x059f:0x1029",
    "", // 0x0100
    "",
    "-d sat"
  },
  { "USB: Lacie rikiki; JMicron",
    "0x059f:0x102a",
    "",
    "",
    "-d usbjmicron,x"
  },
  { "USB: LaCie D2 USB3; LucidPort USB300 ",
    "0x059f:0x103d",
    "",
    "",
    "-d sat"
  },
  { "USB: LaCie rikiki USB 3.0; ",
    "0x059f:0x10(49|57)",
    "",
    "",
    "-d sat"
  },
  { "USB: LaCie minimus USB 3.0; ",
    "0x059f:0x104a",
    "",
    "",
    "-d sat"
  },
  { "USB: LaCie Rugged Mini USB 3.0; ",
    "0x059f:0x1051",
    "", // 0x0000
    "",
    "-d sat"
  },
  { "USB: LaCie; ", // 0x1070: ASMedia 1053 ?
    "0x059f:0x10(6f|7[05])",
    "", // 6f/70=0x0001, 75=0x0000
    "",
    "-d sat"
  },
  // In-System Design
  { "USB: ; In-System/Cypress ISD-300A1",
    "0x05ab:0x0060",
    "", // 0x1101
    "",
    "-d usbcypress"
  },
  // Apple
  { "USB: Apple; ",
    "0x05ac:0x8406", // TOSHIBA MQ01UBB200
    "",
    "",
    "-d sat"
  },
  // Genesys Logic
  { "USB: ; Genesys Logic GL881E",
    "0x05e3:0x0702",
    "",
    "",
    "" // unsupported
  },
  { "USB: ; Genesys Logic", // TODO: requires '-T permissive'
    "0x05e3:0x0718",
    "", // 0x0041
    "",
    "-d sat"
  },
  { "USB: ; Genesys Logic GL3310",
    "0x05e3:0x0731", // Chieftec USB 3.0 2.5" case
    "",
    "",
    "-d sat"
  },
  { "USB: ; Genesys Logic",
    "0x05e3:0x0735",
    "", // 0x1003
    "",
    "-d sat"
  },
  // Micron
  { "USB: Micron USB SSD; ",
    "0x0634:0x0655",
    "",
    "",
    "" // unsupported
  },
  // Prolific
  { "USB: ; Prolific PL2507", // USB->PATA
    "0x067b:0x2507",
    "",
    "",
    "-d usbjmicron,0" // Port number is required
  },
  { "USB: ; Prolific PL2571/2771/2773/2775", // USB->SATA, USB3->SATA,
    "0x067b:0x(2571|277[135])",              // USB3+eSATA->SATA, USB3->2xSATA
    "",
    "",
    "-d usbprolific"
  },
  { "USB: ; Prolific PL3507", // USB+IEEE1394->PATA
    "0x067b:0x3507",
    "", // 0x0001
    "",
    "-d usbjmicron,p"
  },
  // Imation
  { "USB: Imation ; ", // Imation Odyssey external USB dock
    "0x0718:0x1000",
    "", // 0x5104
    "",
    "-d sat"
  },
  // SanDisk
  { "USB: SanDisk SDCZ80 Flash Drive; Fujitsu", // ATA ID: SanDisk pSSD
    "0x0781:0x558[08]",
    "",
    "",
    "-d sat"
  },
  // Freecom
  { "USB: ; Innostor IS631", // No Name USB3->SATA Enclosure
    "0x07ab:0x0621",
    "",
    "",
    "-d sat"
  },
  { "USB: Freecom Quattro 3.0; ", // USB3.0+IEEE1394+eSATA->SATA
    "0x07ab:0xfc77",
    "",
    "",
    "-d sat"
  },
  { "USB: Freecom Mobile Drive XXS; JMicron",
    "0x07ab:0xfc88",
    "", // 0x0101
    "",
    "-d usbjmicron,x"
  },
  { "USB: Freecom Hard Drive XS; Sunplus",
    "0x07ab:0xfc8e",
    "", // 0x010f
    "",
    "-d usbsunplus"
  },
  { "USB: Freecom; ", // Intel labeled
    "0x07ab:0xfc8f",
    "", // 0x0000
    "",
    "-d sat"
  },
  { "USB: Freecom Classic HD 120GB; ",
    "0x07ab:0xfccd",
    "",
    "",
    "" // unsupported
  },
  { "USB: Freecom HD; JMicron", // 500GB
    "0x07ab:0xfcd[6a]",
    "",
    "",
    "-d usbjmicron"
  },
  // Oxford Semiconductor, Ltd
  { "USB: ; Oxford",
    "0x0928:0x0000",
    "",
    "",
    "" // unsupported
  },
  { "USB: ; Oxford OXU921DS",
    "0x0928:0x0002",
    "",
    "",
    "" // unsupported
  },
  { "USB: ; Oxford", // Zalman ZM-VE200
    "0x0928:0x0010",
    "", // 0x0304
    "",
    "-d sat"
  },
  // Toshiba
  { "USB: Toshiba PX1270E-1G16; Sunplus",
    "0x0930:0x0b03",
    "",
    "",
    "-d usbsunplus"
  },
  { "USB: Toshiba PX1396E-3T01; Sunplus", // similar to Dura Micro 501
    "0x0930:0x0b09",
    "",
    "",
    "-d usbsunplus"
  },
  { "USB: Toshiba Stor.E Steel; Sunplus",
    "0x0930:0x0b11",
    "",
    "",
    "-d usbsunplus"
  },
  { "USB: Toshiba Stor.E; ",
    "0x0930:0x0b1[9ab]",
    "", // 0x0001
    "",
    "-d sat"
  },
  // Lumberg, Inc.
  { "USB: Toshiba Stor.E; Sunplus",
    "0x0939:0x0b1[56]",
    "",
    "",
    "-d usbsunplus"
  },
  // Apricorn
  { "USB: Apricorn SATA Wire; ",
    "0x0984:0x0040",
    "",
    "",
    "-d sat"
  },
  // Neodio Technologies
  { "USB: Neodio; Initio INIC-1810PL",
    "0x0aec:0x3050",
    "", // 0x0100
    "",
    "-d sat"
  },
  // Seagate
  { "USB: Seagate External Drive; Cypress",
    "0x0bc2:0x0503",
    "", // 0x0240
    "",
    "-d usbcypress"
  },
  { "USB: Seagate FreeAgent Go; ",
    "0x0bc2:0x2(000|100|101)",
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate FreeAgent Go FW; ",
    "0x0bc2:0x2200",
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate Expansion Portable; ",
    "0x0bc2:0x23(00|12|1a|20|21|22)",
    "", // 12=0x0219, 1a=0x0707, 22=0x0000
    "",
    "-d sat"
  },
  { "USB: Seagate FreeAgent Desktop; ",
    "0x0bc2:0x3000",
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate FreeAgent Desk; ",
    "0x0bc2:0x3001",
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate FreeAgent Desk; ", // 1TB
    "0x0bc2:0x3008",
    "",
    "",
    "-d sat,12"
  },
  { "USB: Seagate FreeAgent XTreme; ",
    "0x0bc2:0x3101",
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate Expansion Desktop; ",
    "0x0bc2:0x33(00|1[2a]|2[012]|3[02])", // 1a=5TB, 21=4TB
    "", // 1a=0x0909
    "",
    "-d sat"
  },
  { "USB: Seagate FreeAgent GoFlex USB 2.0; ",
    "0x0bc2:0x502[01]",
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate FreeAgent GoFlex USB 3.0; ",
    "0x0bc2:0x5030",
    "", // 0x0100
    "",
    "-d sat"
  },
  { "USB: Seagate FreeAgent GoFlex USB 3.0; ",
    "0x0bc2:0x5031",
    "",
    "",
    "-d sat,12"
  },
  { "USB: Seagate FreeAgent; ",
    "0x0bc2:0x5040",
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate FreeAgent GoFlex USB 3.0; ", // 2TB
    "0x0bc2:0x507[01]",
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate FreeAgent GoFlex Desk USB 3.0; ", // 3TB
    "0x0bc2:0x50a1",
    "",
    "",
    "-d sat,12" // "-d sat" does not work (ticket #151)
  },
  { "USB: Seagate FreeAgent GoFlex Desk USB 3.0; ", // 2TB, 4TB
    "0x0bc2:0x50a[57]",
    "", // 0x0100
    "",
    "-d sat"
  },
  { "USB: Seagate FreeAgent / Maxtor D3; ",
    // 0x6121: Seagate FreeAgent GoFlex Pro for Mac (0x0148)
    // 0x6123: Maxtor D3 Station 3TB (0x0209)
    // 0x6126: Maxtor D3 Station 5TB (0x0209)
    "0x0bc2:0x612[136]",
    "",
    "",
    "-d sat"
  },
  { "USB: Maxtor M3 Portable; ",
    "0x0bc2:0x61b7", // Maxtor M3 Portable 4TB (0x0000)
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate Backup Plus USB 3.0; ", // 1TB
    "0x0bc2:0xa0[01]3",
    "", // 0x0100
    "",
    "-d sat"
  },
  { "USB: Seagate Backup Plus Desktop USB 3.0; ",
    "0x0bc2:0xa(0a[14]|b3[14])", // 4TB, 3TB (8 LBA/1 PBA offset), 5TB, ?
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate Slim Portable Drive; ", // SRD00F1
    "0x0bc2:0xab00",
    "",
    "",
    "-d sat"
  },
  { "USB: Seagate Backup Plus USB 3.0; ",
    // 0xab1e: Seagate Backup Plus 4TB
    // 0xab24: Seagate Backup Plus Slim (0x0100) (ticket #443)
    // 0xab25: Seagate Backup Plus for Mac (0x0100)
    // 0xab38: Seagate Backup Plus 8TB (0x0100) (ticket #786)
    "0x0bc2:0xab(1e|2[01458]|38)",
    "",
    "",
    "-d sat"
  },
  // Addonics
  { "USB: Addonics HDMU3; ", // (ticket #609)
    "0x0bf6:0x1001",
    "", // 0x0100
    "",
    ""
  },
  // Dura Micro
  { "USB: Dura Micro; Cypress",
    "0x0c0b:0xb001",
    "", // 0x1110
    "",
    "-d usbcypress"
  },
  { "USB: Dura Micro; Initio",
    "0x0c0b:0xb136",
    "", // 0x0108
    "",
    "-d sat"
  },
  { "USB: Dura Micro 509; Sunplus",
    "0x0c0b:0xb159",
    "", // 0x0103
    "",
    "-d usbsunplus"
  },
  // Maxtor
  { "USB: Maxtor OneTouch 200GB; ",
    "0x0d49:0x7010",
    "",
    "",
    "" // unsupported
  },
  { "USB: Maxtor OneTouch; ",
    "0x0d49:0x7300",
    "", // 0x0121
    "",
    "-d sat"
  },
  { "USB: Maxtor OneTouch 4; ",
    "0x0d49:0x7310",
    "", // 0x0125
    "",
    "-d sat"
  },
  { "USB: Maxtor OneTouch 4 Mini; ",
    "0x0d49:0x7350",
    "", // 0x0125
    "",
    "-d sat"
  },
  { "USB: Maxtor BlackArmor Portable; ",
    "0x0d49:0x7550",
    "",
    "",
    "-d sat"
  },
  { "USB: Maxtor Basics Desktop; ",
    "0x0d49:0x7410",
    "", // 0x0122
    "",
    "-d sat"
  },
  { "USB: Maxtor Basics Portable; ",
    "0x0d49:0x7450",
    "", // 0x0122
    "",
    "-d sat"
  },
  // Jess-Link International
  { "USB: ; Cypress", // Medion HDDrive2Go
    "0x0dbf:0x9001",
    "", // 0x0240
    "",
    "-d usbcypress"
  },
  // Oyen Digital
  { "USB: Oyen Digital MiniPro USB 3.0; ",
    "0x0dc4:0x020a",
    "",
    "",
    "-d sat"
  },
  // Cowon Systems, Inc.
  { "USB: Cowon iAudio X5; ",
    "0x0e21:0x0510",
    "",
    "",
    "-d usbcypress"
  },
  // iRiver
  { "USB: iRiver iHP-120/140 MP3 Player; Cypress",
    "0x1006:0x3002",
    "", // 0x0100
    "",
    "-d usbcypress"
  },
  // Western Digital
  { "USB: WD My Passport (IDE); Cypress",
    "0x1058:0x0701",
    "", // 0x0240
    "",
    "-d usbcypress"
  },
  { "USB: WD Elements Desktop; ",
    "0x1058:0x10(01|03|21|7c)",
    "", // 01=0x0104, 03=0x0175, 21=0x2002, 7c=0x1065
    "",
    "-d sat"
  },
  { "USB: WD Elements / My Passport; ", // 2.5" with integrated USB
    "0x1058:0x(07(0[245a]|1a|30|4[0128a]|a[8e])|"
              "08(1[06]|2[02]|3[37a])|"
              "10(10|23|4[28]|7d|a[28]|b8)|"
              "25(9[9df]|a[12]|e2|fa))",
    "", // 0x0822=0x1007, 37=0x1072
        // 0x1010=0x0105, 7d=0x1073, a8=0x1042, b8=0x1007
        // 0x2599=0x1012, 9d/a1=0x1005, 9f/a2=0x1004
    "",
    "-d sat"
  },
  { "USB: WD My Book / Easystore; ", // 3.5"
    "0x1058:0x(09(0[06]|10)|11(0[01245]|1[0d]|30|40)|1230|25(a3|fb))",
    "", // 0x0906=0x0012, 10=0x0106
        // 0x1100/01=0x0165, 02=0x1028, 10=0x1030, 1d=0x1020, 30=0x1012, 40=0x1003
        // 0x1230=0x1065, 0x25a3=0x1013, 0x25fb=0x3004
    "",
    "-d sat"
  },
  // Atech Flash Technology
  { "USB: ; Atech", // Enclosure from Kingston SSDNow notebook upgrade kit
    "0x11b0:0x6298",
    "", // 0x0108
    "",
    "-d sat"
  },
  // ADATA
  { "USB: ADATA; ",
    "0x125f:0xa(11|31|35|15)a", // 0xa11a: Classic CH11 1TB, 0xa31a: HV620 2TB (0x0100)
    "", // 0xa35a: HD650 2TB (0x6503), 0xa15a: HD710 1TB
    "",
    "-d sat"
  },
  { "USB: ADATA; Cypress",
    "0x125f:0xa9[34]a", // 0xa93a: SH93 (0x0150)
    "",
    "",
    "-d usbcypress"
  },
  // Initio
  { "USB: ; Initio 316000",
    "0x13fd:0x0540",
    "",
    "",
    "" // unsupported
  },
  { "USB: ; Initio", // Thermaltake BlacX
    "0x13fd:0x0840",
    "",
    "",
    "-d sat"
  },
  { "USB: ; Initio", // USB->SATA+PATA, Chieftec CEB-25I
    "0x13fd:0x1040",
    "", // 0x0106
    "",
    "" // unsupported
  },
  { "USB: ; Initio 6Y120L0", // CoolerMaster XCraft RX-3HU
    "0x13fd:0x1150",
    "",
    "",
    "" // unsupported
  },
  { "USB: ; Initio", // USB->SATA
    "0x13fd:0x1240",
    "", // 0x0104
    "",
    "-d sat"
  },
  { "USB: ; Initio", // USB+SATA->SATA
    "0x13fd:0x1340",
    "", // 0x0208
    "",
    "-d sat"
  },
  { "USB: ; Initio",
    "0x13fd:0x16[45]0",
    "", // 0x1640: 0x0864, 0x1650: 0x0436
    "",
    "-d sat,12" // some SMART commands fail, see ticket #295
  },
  { "USB: Intenso Memory Station 2,5\"; Initio",
    "0x13fd:0x1840",
    "",
    "",
    "-d sat"
  },
  { "USB: ; Initio", // NexStar CX USB enclosure
    "0x13fd:0x1e40",
    "",
    "",
    "-d sat"
  },
  { "USB: ; Initio",
    "0x13fd:0x39[124]0", // 0x3910: Seagate Expansion Portable SRD00F1 (0x0100)
    "", // 0x3920: ezDISK EZ370 (0x0205)
    "", // 0x3940: MS-TECH LU-275S (0x0306)
    "-d sat"
  },
  // Super Top
  { "USB: Super Top generic enclosure; ",
    "0x14cd:0x6116",
    "", // 0x0150, older report suggests -d usbcypress
    "", // 0x0160 also reported as unsupported
    "-d sat"
  },
  // JMicron
  { "USB: ; JMicron JMS539", // USB2/3->SATA (old firmware)
    "0x152d:0x0539",
    "0x0100",      // 1.00, various devices support -d usbjmicron
    "",            // 1.00, SSI SI-1359RUS3 supports -d sat,
    ""             //       -d usbjmicron may disconnect drive (ticket #552)
  },
  { "USB: ; JMicron JMS539", // USB2/3->SATA (new firmware)
    "0x152d:0x0539",
    "0x020[56]|"   //  2.05, ZTC USB 3.0 enclosure (ticket #338)
    "0x28(03|12)", // 28.03, Mediasonic ProBox HF2-SU3S2 Rev 2 (port multiplier, ticket #504)
    "",            // 28.12, Mediasonic ProBox H82-SU3S2 (port multiplier)
    "-d sat"
  },
  { "USB: ; JMicron ", // USB->SATA->4xSATA (port multiplier)
    "0x152d:0x0551",   // JMS539? (old firmware may use 0x152d:0x0539, ticket #552)
    "", // 0x0100
    "",
    "-d usbjmicron,x"
  },
  { "USB: ; JMicron", // USB2/3->2xSATA
    "0x152d:0x0565",
    "", // 0x9114, Akasa DuoDock X (ticket #607)
    "",
    "-d sat"
  },
  { "USB: ; JMicron JMS567", // USB2/3->SATA
    "0x152d:0x0567",
    "", // 0x0114
    "", // 0x0205, 2.05, Mediasonic ProBox HF2-SU3S2 Rev 3 (port multiplier, ticket #504)
    "-d sat"
  },
  { "USB: ; JMicron JMS578", // USB->SATA
    "0x152d:0x0578",
    "", // 0x0100
    "",
    "-d sat"
  },
  { "USB: ; JMicron",
    "0x152d:0x0579", // Intenso External
    "", // 0x0100
    "",
    "-d sat"
  },
  { "USB: OCZ THROTTLE OCZESATATHR8G; JMicron JMF601",
    "0x152d:0x0602",
    "",
    "",
    "" // unsupported
  },
  { "USB: ; JMicron JMS561", // USB2/3->2xSATA
    "0x152d:0x[19]561", // 0x1561(0x0106), Sabrent USB 3.0 Dual Bay SATA Dock
    "",  // 0x9561(0x0105), Orico 6629US3-C USB 3.0 Dual Bay SATA Dock
    "",
    "-d sat"
  },
  { "USB: ; JMicron JM20329", // USB->SATA
    "0x152d:0x2329",
    "", // 0x0100
    "",
    "-d usbjmicron"
  },
  { "USB: ; JMicron JM20336", // USB+SATA->SATA, USB->2xSATA
    "0x152d:0x2336",
    "", // 0x0100
    "",
    "-d usbjmicron,x"
  },
  { "USB: Generic JMicron adapter; JMicron",
    "0x152d:0x2337",
    "",
    "",
    "-d usbjmicron"
  },
  { "USB: ; JMicron JM20337/8", // USB->SATA+PATA, USB+SATA->PATA
    "0x152d:0x2338",
    "", // 0x0100
    "",
    "-d usbjmicron"
  },
  { "USB: ; JMicron JM20339", // USB->SATA
    "0x152d:0x2339",
    "", // 0x0100
    "",
    "-d usbjmicron,x"
  },
  { "USB: ; JMicron", // USB+SATA->SATA
    "0x152d:0x2351",  // e.g. Verbatim Portable Hard Drive 500Gb
    "", // 0x0100
    "",
    "-d sat"
  },
  { "USB: ; JMicron", // USB->SATA
    "0x152d:0x2352",
    "", // 0x0100
    "",
    "-d usbjmicron,x"
  },
  { "USB: ; JMicron", // USB->SATA
    "0x152d:0x2509",
    "", // 0x0100
    "",
    "-d usbjmicron,x"
  },
  { "USB: ; JMicron JMS566", // USB3->SATA
    "0x152d:0x2566", // e.g. Chieftec CEB-7035S
    "", // 0x0114
    "",
    "-d usbjmicron,x"
  },
  { "USB: ; JMicron",
    "0x152d:0x2590",
    "", // 0x0x8105 (ticket #550)
    "",
    "-d sat"
  },
  { "USB: ; JMicron JMS567", // USB2/3->SATA
    "0x152d:0x3562",
    "", // 0x0310, StarTech S358BU33ERM (port multiplier, ticket #508)
    "",
    "-d sat"
  },
  { "USB: ; JMicron", // USB3->SATA
    "0x152d:0x3569",
    "", // 0x0203
    "",
    "-d sat"
  },
  { "USB: ; JMicron JMS561U", // USB3->2xSATA
    "0x152d:0x8561",
    "", // 0x0107
    "",
    "-d sat"
  },
  // ASMedia
  { "USB: ; ASMedia ASM1053/1153/1351",
    "0x174c:0x1([01]53|351)",
    "",
    "",
    "-d sat"
  },
  { "USB: ; ASMedia ASM1051",
    "0x174c:0x5106", // 0x174c:0x55aa after firmware update
    "",
    "",
    "-d sat"
  },
  { "USB: ; ASMedia AS2105", // Icy Box IB-AC603A-U3
    "0x174c:0x5136",
    "", // 0x0001
    "",
    "-d sat"
  },
  { "USB: ; ASMedia", // Vantec NexStar USB 3.0 & SATA dual drive dock
    "0x174c:0x5516",
    "",
    "",
    "-d sat"
  },
  { "USB: ; ASMedia", // MEDION HDDrive-n-GO, LaCie Rikiki USB 3.0,
      // Silicon Power Armor A80 (ticket #237)
      // reported as unsupported: BYTECC T-200U3, Kingwin USB 3.0 docking station
    "0x174c:0x55aa",
    "", // 0x0100
    "",
    "-d sat"
  },
  // LucidPort
  { "USB: ; LucidPORT USB300", // RaidSonic ICY BOX IB-110StU3-B, Sharkoon SATA QuickPort H3
    "0x1759:0x500[02]", // 0x5000: USB 2.0, 0x5002: USB 3.0
    "",
    "",
    "-d sat"
  },
  { "USB: ; LucidPort", // Fuj:tech SATA-USB3 dock
    "0x1759:0x5100",
    "", // 0x2580
    "",
    "-d sat"
  },
  // Verbatim
  { "USB: Verbatim Portable Hard Drive; Sunplus",
    "0x18a5:0x0214",
    "", // 0x0112
    "",
    "-d usbsunplus"
  },
  { "USB: Verbatim FW/USB160; Oxford OXUF934SSA-LQAG", // USB+IEEE1394->SATA
    "0x18a5:0x0215",
    "", // 0x0001
    "",
    "-d sat"
  },
  { "USB: Verbatim External Hard Drive 47519; Sunplus", // USB->SATA
    "0x18a5:0x0216",
    "",
    "",
    "-d usbsunplus"
  },
  { "USB: Verbatim Pocket Hard Drive; JMicron", // SAMSUNG SpinPoint N3U-3 (USB, 4KiB LLS)
    "0x18a5:0x0227",
    "",
    "",
    "-d usbjmicron" // "-d usbjmicron,x" does not work
  },
  { "USB: Verbatim External Hard Drive; JMicron", // 2TB
    "0x18a5:0x022a",
    "",
    "",
    "-d usbjmicron"
  },
  { "USB: Verbatim Store'n'Go; JMicron", // USB->SATA
    "0x18a5:0x022b",
    "", // 0x0100
    "",
    "-d usbjmicron"
  },
  { "USB: Verbatim Pocket Hard Drive; ", // 1TB USB 3.0
    "0x18a5:0x0237",
    "",
    "",
    "-d sat,12"
  },
  { "USB: Verbatim External Hard Drive; ", // 3TB USB 3.0
    "0x18a5:0x0400",
    "",
    "",
    "-d sat"
  },
  // Silicon Image
  { "USB: Vantec NST-400MX-SR; Silicon Image 5744",
    "0x1a4a:0x1670",
    "",
    "",
    "" // unsupported
  },
  // Corsair
  { "USB: Voyager GTX; ",
    "0x1b1c:0x1a0e",
    "",
    "",
    "-d sat"
  },
  // SunplusIT
  { "USB: ; SunplusIT",
    "0x1bcf:0x0c31",
    "",
    "",
    "-d usbsunplus"
  },
  // TrekStor
  { "USB: TrekStor DataStation; ", // DataStation maxi light (USB 3.0)
    "0x1e68:0x0050",
    "", // 0x0100
    "",
    "-d sat"
  },
  // Innostor
  { "USB: ; Innostor IS611", // USB3->SATA+PATA
    "0x1f75:0x0611", // SMART access via PATA does not work
    "",
    "",
    "-d sat"
  },
  { "USB: ; Innostor IS621", // USB3->SATA
    "0x1f75:0x0621", // Dynex 2.5" USB 3.0 Exclosure DX-HD302513
    "",
    "",
    "-d sat"
  },
  { "USB: ; Innostor IS888", // USB3->SATA
    "0x1f75:0x0888",
    "", // 0x0034, Sharkoon SATA QuickDeck Pro USB 3.0 (unsupported)
    "", // 0x0036, works with -d sat (ticket #827)
    "-d sat"
  },
  // VIA Labs
  { "USB: ; VIA VL701", // USB2/3->SATA
    "0x2109:0x0701", // Intenso 2,5" 1TB USB3
    "", // 0x0107
    "",
    "-d sat" // ATA output registers missing
  },
  { "USB: ; VIA VL711", // USB2/3->SATA
    "0x2109:0x0711",
    "", // 0x0114, Mediasonic ProBox K32-SU3 (ticket #594)
    "", // 0x0507, Intenso 2,5" Memory Case 2TB USB3
    "-d sat"
  },
  // 0x2537 (?)
  { "USB: ; ", // USB 3.0
    "0x2537:0x106[68]", // 0x1066: Orico 2599US3, 0x1068: Fantec ER-35U3
    "", // 0x0100
    "",
    "-d sat"
  },
  // Power Quotient International
  { "USB: PQI H560; ",
    "0x3538:0x0902",
    "", // 0x0000
    "",
    "-d sat"
  },
  // Power Quotient International
  { "USB: PQI bridge; ",
    "0x3538:0x0064",
    "",
    "",
    "-d usbsunplus"
  },
  // Sharkoon
  { "USB: Sharkoon QuickPort XT USB 3.0; ",
     "0x357d:0x7788",
     "",
     "",
     "-d sat"
  },
  // Hitachi/SimpleTech
  { "USB: Hitachi Touro Desk; JMicron", // 3TB
    "0x4971:0x1011",
    "",
    "",
    "-d usbjmicron"
  },
  { "USB: Hitachi Touro; ",
    "0x4971:0x101[45]", // 14=1TB, 15=2TB
    "", // 0x0000
    "",
    "-d sat" // ATA output registers missing
  },
  { "USB: Hitachi Touro Mobile; ", // 1TB
    "0x4971:0x102[034]",
    "", // 0x0100
    "",
    "-d sat"
  },
  { "USB: SimpleTech;", // USB 3.0 HDD BOX Agestar,  Rock External HDD 3,5" UASP
    "0x4971:0x8017",
    "",
    "",
    "-d sat"
  },
  { "USB: Hitachi/SimpleTech; JMicron", // 1TB
    "0x4971:0xce17",
    "",
    "",
    "-d usbjmicron,x"
  },
  // OnSpec
  { "USB: ; OnSpec", // USB->PATA
    "0x55aa:0x2b00",
    "", // 0x0100
    "",
    "" // unsupported
  },
  // 0x6795 (?)
  { "USB: Sharkoon 2-Bay RAID Box; ", // USB 3.0
    "0x6795:0x2756",
    "", // 0x0100
    "",
    "-d sat"
  },
  // JMicron II
  { "USB: ; JMicron JMS566",
    "0xa152:0xb566",
    "", // 0x0223
    "",
    "-d sat"
  },
  // 0xabcd (?)
  { "USB: ; ",
    "0xabcd:0x610[34]", // 0x6103: LogiLink AU0028A V1.0 USB 3.0 to IDE & SATA Adapter
      // 0x6104: LogiLink PCCloneEX Lite
    "",
    "",
    "-d sat"
  },
/*
}; // builtin_knowndrives[]
 */
