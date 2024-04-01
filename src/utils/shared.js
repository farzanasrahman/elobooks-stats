/**
 * Returns string value of html template after getting total sales and purchase amount
 * @param {number} totalSalesAmount
 * @param {number} totalPurchaseAmount
 * @returns string
 */
export const getDailyStatTemplate = (totalSalesAmount, totalPurchaseAmount) => {
  return `<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html dir="ltr" xmlns="http://www.w3.org/1999/xhtml" xmlns:o="urn:schemas-microsoft-com:office:office"><head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1" name="viewport">
    <meta name="x-apple-disable-message-reformatting">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="telephone=no" name="format-detection">
    <title></title>
    <!--[if (mso 16)]>
      <style type="text/css">
      a {text-decoration: none;}
      </style>
      <![endif]-->
    <!--[if gte mso 9]><style>sup { font-size: 100% !important; }</style><![endif]-->
    <!--[if gte mso 9]>
  <xml>
      <o:OfficeDocumentSettings>
      <o:AllowPNG></o:AllowPNG>
      <o:PixelsPerInch>96</o:PixelsPerInch>
      </o:OfficeDocumentSettings>
  </xml>
  <![endif]-->
    <!--[if !mso]><!-- -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@600&display=swap" rel="stylesheet">
    <!--<![endif]-->
   <!--[if mso]>
   <style type="text/css">
       ul {
    margin: 0 !important;
    }
    ol {
    margin: 0 !important;
    }
    li {
    margin-left: 47px !important;
    }
  
   </style><![endif]
  --></head>
   <body class="body">
    <div dir="ltr" class="es-wrapper-color">
     <!--[if gte mso 9]>
              <v:background xmlns:v="urn:schemas-microsoft-com:vml" fill="t">
                  <v:fill type="tile" src="https://tlr.stripocdn.email/content/guids/CABINET_8fbba731b18c07448ff3a0b3cb247c11/images/group_nUw.png" color="#02687F" origin="0.5, 0" position="0.5, 0"></v:fill>
              </v:background>
          <![endif]-->
     <table class="es-wrapper" width="100%" cellspacing="0" cellpadding="0" esd-img-prev-position="center top" style="background-position: center top;" background="https://ffqaedf.stripocdn.email/content/guids/CABINET_8fbba731b18c07448ff3a0b3cb247c11/images/group_nUw.png">
      <tbody>
       <tr>
        <td class="esd-email-paddings" valign="top">
         <table cellpadding="0" cellspacing="0" class="esd-header-popover es-header" align="center">
          <tbody>
           <tr>
            <td class="esd-stripe" align="center">
             <table bgcolor="#ffffff" class="es-header-body" align="center" cellpadding="0" cellspacing="0" width="600" style="border-radius: 20px 20px 0 0">
              <tbody>
               <tr>
                <td class="esd-structure es-p20" align="left">
                 <!--[if mso]><table width="560" cellpadding="0"
                              cellspacing="0"><tr><td width="180" valign="top"><![endif]-->
                 <table cellpadding="0" cellspacing="0" class="es-left" align="left">
                  <tbody>
                   <tr>
                    <td width="180" class="es-m-p0r es-m-p20b esd-container-frame" valign="top" align="center">
                     <table cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                       <tr>
                        <td align="center" class="esd-block-image" style="font-size: 0px;"><a target="_blank" href="https://elobooks.net/"><img src="https://ffqaedf.stripocdn.email/content/guids/CABINET_3b531cbaca4018b27e93f657b69b0c2fff030595ec18f7f9a3d3885ba33805ba/images/screen_shot_20240401_at_103315_am.png" alt="Logo" style="display:block" width="180" title="Logo" class="adapt-img"></a></td>
                       </tr>
                      </tbody>
                     </table></td>
                   </tr>
                  </tbody>
                 </table>
                 <!--[if mso]></td><td width="20"></td><td width="360" valign="top"><![endif]-->
                 <table cellpadding="0" cellspacing="0" align="right">
                  <tbody>
                   <tr>
                    <td width="360" align="left" class="esd-container-frame">
                     <table cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                       <tr>
                        <td align="center" class="esd-block-spacer" height="8"></td>
                       </tr>
                       <tr>
                        <td class="esd-block-menu">
                         <table cellpadding="0" cellspacing="0" width="100%" class="es-menu">
                          <tbody>
                           <tr>
                            <td align="center" valign="top" width="25%" class="es-p10t es-p10b es-p5r es-p5l"><a target="_blank" href="https://elobooks.net/">HOME</a></td>
                            <td align="center" valign="top" width="25%" class="es-p10t es-p10b es-p5r es-p5l"><a target="_blank" href="https://elobooks.net/">ABOUT US</a></td>
                            <td align="center" valign="top" width="25%" class="es-p10t es-p10b es-p5r es-p5l"><a target="_blank" href="https://elobooks.net/">SERVICES</a></td>
                            <td align="center" valign="top" width="25%" class="es-p10t es-p10b es-p5r es-p5l"><a target="_blank" href="https://elobooks.net/">CONTACT</a></td>
                           </tr>
                          </tbody>
                         </table></td>
                       </tr>
                      </tbody>
                     </table></td>
                   </tr>
                  </tbody>
                 </table>
                 <!--[if mso]></td></tr></table><![endif]--></td>
               </tr>
               <tr>
                <td class="esd-structure es-p20r es-p20l" align="left">
                 <table cellpadding="0" cellspacing="0" width="100%">
                  <tbody>
                   <tr>
                    <td width="560" class="esd-container-frame" align="center" valign="top">
                     <table cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                       <tr>
                        <td align="center" class="esd-block-spacer es-p10t es-p10b" style="font-size:0">
                         <table border="0" width="100%" height="100%" cellpadding="0" cellspacing="0">
                          <tbody>
                           <tr>
                            <td style="border-bottom: 2px solid #53c7b4; background: none; height: 1px; width: 100%; margin: 0px;"></td>
                           </tr>
                          </tbody>
                         </table></td>
                       </tr>
                      </tbody>
                     </table></td>
                   </tr>
                  </tbody>
                 </table></td>
               </tr>
              </tbody>
             </table></td>
           </tr>
          </tbody>
         </table>
         <table cellpadding="0" cellspacing="0" class="es-content" align="center">
          <tbody>
           <tr>
            <td class="esd-stripe" align="center">
             <table bgcolor="#ffffff" class="es-content-body" align="center" cellpadding="0" cellspacing="0" width="600">
              <tbody>
               <tr>
                <td class="esd-structure es-p20t es-p20r es-p20l" align="left">
                 <table cellpadding="0" cellspacing="0" width="100%">
                  <tbody>
                   <tr>
                    <td width="560" class="esd-container-frame" align="center" valign="top">
                     <table cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                       
                       <tr>
                        <td align="center" class="esd-block-text es-p20t es-p5b"><h2 style="color: #d40c29;">— Daily Statistics —</h2></td>
                       </tr>
                       <tr>
                        <td align="center" class="esd-block-text"><h4 class=" es-m-txt-c">${new Date().toLocaleDateString()}</h4></td>
                       </tr>
                      </tbody>
                     </table></td>
                   </tr>
                  </tbody>
                 </table></td>
               </tr>
               <tr>
                <td class="esd-structure es-p10t es-p20r es-p20l" align="left">
                 <table cellpadding="0" cellspacing="0" width="100%">
                  <tbody>
                   <tr>
                    <td width="560" class="es-m-p20b esd-container-frame" align="left">
                     <table cellpadding="0" cellspacing="0" width="100%">
                      <tbody>
                       <tr>
                        <td align="center" class="esd-block-text es-p15b es-p40r es-p40l es-m-p0r es-m-p0l"><h6 align="left">Total Purchase: &nbsp;${totalPurchaseAmount} Taka.</h6><h6 align="left">Total Sale: ${totalSalesAmount} Taka.</h6></td>
                       </tr>
                      </tbody>
                     </table></td>
                   </tr>
                   
                  </tbody>
                 </table></td>
               </tr>
              </tbody>
             </table></td>
           </tr>
          </tbody>
         </table>
         </td>
       </tr>
      </tbody>
     </table>
    </div>
   
  </body></html>`;
};
