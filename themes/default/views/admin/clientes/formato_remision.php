<?php ob_start();?>

    
<table>
<tr>
    <td><img src="/plataforma/beta/assets/img/logo.png" alt="" style="max-width:100%"></td>
    <td><p style="font-size:0.7em;font-family: verdana;">COJUNAL<br>COBRANZAS JURIDICAS NACIONALES</p></td>
    <td align="right" style="padding-left:80px;font-size:0.7em;font-family: verdana;">Remision #: <?php echo $DataRemisiones[0]['id'] ?></td>
</tr>
</table>




<div class="container" style="font-family: verdana;">
       

    <br><br>
        <div class="row" >
            <div class="row voffset4" >
                <p style="font-size:0.7em;font-family: verdana;">Remision corresponde a la prestación de servicios de cobranza<br><hr></p>
                <table width="100%" style="font-size:0.7em;font-family: verdana;">
                <tr>
                    <td>Cliente: <?php echo $DataRemisiones[0]['name'] ?></td>
                    <td>Nit: <?php echo $DataRemisiones[0]['idNumber'] ?></td>
                    <td>Periodo: <?php echo $DataRemisiones[0]['idNumber'] ?></td>
                </tr>
                </table>
            </div>

            <div class="row voffset4">
            <table width="100%" style="font-size:0.7em;font-family: verdana;">
                <tr>
                    <td>Campaña: <?php echo $DataRemisiones[0]['campaignName'] ?></td>
                    <td>Fecha: <?php echo $DataRemisiones[0]['fecha'] ?></td>                  
                </tr>
                </table>           
            </div>


        <div class="row voffset4">
            <p style="font-size:0.7em;font-family: verdana;">Esta campaña se desarrollo bajo la siguiente negociación<br><hr></p>
            <table width="100%" style="font-size:0.7em;font-family: verdana;">
                <tr>
                    <td>Honorarios: <?php echo $DataRemisiones[0]['honorarios'] ?>%</td>
                    <td>Intereses: <?php echo $DataRemisiones[0]['intereses'] ?>%</td>        
                    <td>Comision de recaudo: <?php echo $DataRemisiones[0]['comision'] ?>%</td>                  
                </tr>
                <tr>
                    <td>% de recuperación: 0%<?php //echo $DataRemisiones[0]['honorarios'] 
 /*
realpath('./').
                    http://cojunal.com/plataforma/beta/admin/listapaymentsbywallets
                   
                    $paymentAmount = 0;                            
                            if (count($payments) > 0){ 
                              foreach ($payments as $payment) {
                                $paymentAmount += $payment->value;                              
                              }
                            }
                            $recoveryPorc = ($paymentAmount * 100) / $model->capitalValue; 
                    */
                    
                    ?></td>
                    <td>Valor inicial: 0<?php //echo $DataRemisiones[0]['intereses'] ?></td>        
                    <td>Saldo pendiente por recaudar : 0<?php //echo $DataRemisiones[0]['comision'] ?></td>                  
                </tr>
                </table> 
        </div>
        <br><br>

        <div class="row voffset8">
        <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-1"></div>
                <div class="col-md-2"></div>
                <div class="col-md-2"></div>
                <div class="col-md-1"></div>
                <div class="col-md-2"></div>
                <div class="col-md-2"></div>

                <table width="100%" style="font-size:10px;font-family: verdana;">
                <tr>
                    <th>#</th>
                    <th>Nombre del deudor</th>
                    <th>Saldo adeudado</th>        
                    <th style="width:15%">Honorarios cobrados</th>   
                    <th>% comision</th>   
                    <th>Valor total recaudado</th> 
                    <th>Valor total cojunal</th>  
                    <th>Estado</th>  
                </tr>
                <?php $cont = 1;  foreach($Walletslist as $list_info_re){?>
                <tr>
                    <td><?php echo $cont; ?></td>
                    <td align="left"><p ><?php echo $list_info_re['legalName'] ?></p></td>
                    <td align="center"><?php echo number_format($list_info_re['intereses'] *  $list_info_re['monto'],1)?></td>        
                    <td align="center"><p ><?php echo number_format($list_info_re['honorarios']) ?></p></td>   
                    <td align="center"><p ><?php echo $list_info_re['comision'] ?>%</p></td>   
                    <td align="center"><?php echo number_format($list_info_re['recaudo'],1) ?></td> 
                    <td align="center"><?php echo number_format( ($list_info_re['recaudo'] * $list_info_re['comision']) / 100 ) ?></td>  
                    <td align="center"> <?php if( $list_info_re['monto'] == 0){ echo "cancelada"; }else{ echo "pendiente";} ?></td>  
                </tr>
                <?php $cont++; }?>
                </table> 

            </div> 
           
        </div>
    <br><br>
<hr>
    <div class="container-fluid text-center voffset9" style="font-size:0.7em;font-family: verdana;">
        <div class="row content">
            <p>El valor total recaudado fue de  el valor correspondiente para COJUNAL por la prestacion del servicio es de </p>


        </div>
    </div>

    <footer class="container-fluid text-center" style="font-size:0.7em;font-family: verdana;">
        <p>Consideraciones legales y firmas de cojunal</p>
    </footer>

        </div>


        </div>    
        
            </body>
            </html>
<?php
 $content = ob_get_clean();

 $mpdf = new \mPDF();
 //$stylesheet = file_get_contents('https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css');
 //$mpdf->WriteHTML($stylesheet,1);
 $mpdf->WriteHTML($content,2);
 $mpdf->Output();
?>

       


   
