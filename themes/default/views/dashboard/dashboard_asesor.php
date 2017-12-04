<style>
  #example_filter {
    display: none;
  }
  .elipsis {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    padding-bottom: 0;
  }
  input.input-search {
    font-weight: normal;
    margin-top: 15px !important;
    margin-bottom: 15px !important;
    font-size: 13px !important; 
  }
  .b-title {
    display: block;
    padding-bottom: 15px;
    padding-top: 15px;
    border-bottom: 1px solid #e8e8e8;
  }
</style>

<section class="cont_home">       
  <section class="conten_inicial">
    <div class="panelBG wow fadeInUp m_b_20 animated animated">
      <section class="wrapper_l dashContent p_t_25">
        
        <section class="padding">
          
          <section class="row m_b_20">
            <div class="dates_pend wow fadeInDown animated" style="visibility: visible; animation-name: fadeInDown;">
              <div class="large-8 medium-8 small-12 columns boxs">
                <div class="panel">
                  <h1>Deudores</h1>
                  <h2>Número de deudores: <?php echo count($deudores); ?></h2>
                </div>
              </div>
              <div class="large-4 medium-4 small-12 columns boxs">
                <div class="panel">
                  <p><b>Porcentaje de recuperacion total:</b> <?php echo $porcentaje_recuperacion[0]['porcentaje']; ?>%</p>
                  <a href="/plataforma/dashboard">Ver cuadrantes <i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                </div>
              </div>
            </div>
          </section>

          <div class="panelBG m_b_20 lista_all_deudor">  
            <table id="example" class="bordered highlight responsive-table">

              <thead>
                <tr>
                  <th class="txt_center formweb elipsis"> 
                    <span class="b-title">Nombre de campaña</span>
                    <input type="text" id="column0_search" class="input-search"> 
                  </th>
                  <th class="txt_center formweb elipsis"> 
                    <span class="b-title">Nombre/Razón Social</span>
                    <input type="text" id="column1_search" class="input-search"> 
                  </th>
                  <th class="txt_center formweb elipsis"> 
                    <span class="b-title">Cedula/Nit</span>
                    <input type="text" id="column2_search" class="input-search"> 
                  </th>
                  <th class="txt_center formweb elipsis"> 
                    <span class="b-title">Ciudad</span>
                    <input type="text" id="column3_search" class="input-search"> 
                  </th>
                  <th class="txt_center formweb elipsis"> 
                    <span class="b-title">Fecha de Asignación</span>
                    <input type="text" disabled="true" class="input-search">
                  </th>
                  <th class="txt_center formweb elipsis"> 
                    <span class="b-title">Capital</span>
                    <input type="text" disabled="true" class="input-search">
                  </th>
                  <th class="txt_center formweb elipsis"> 
                    <span class="b-title">Saldo</span>
                    <input type="text" disabled="true" class="input-search">
                  </th>
                  <th class="txt_center formweb elipsis"> 
                    <span class="b-title">Estado</span>
                    <input type="text" id="column7_search" class="input-search"> 
                  </th>
                  <th class="txt_center formweb elipsis"> 
                    <span class="b-title">Edad</span>
                    <input type="text" id="column7_search" class="input-search"> 
                  </th>
                  <th class="txt_center formweb elipsis"> 
                    <span class="b-title">Clasificación</span>
                    <input type="text" id="column9_search" class="input-search"> 
                  </th>
                </tr>
              </thead>
              <tbody>
                <?php if (!empty($deudores)): ?>
                  <?php foreach ($deudores as $deudor): ?>
                    <tr>
                      <td><?php echo $deudor['campana']; ?></td>
                      <td>
                        <a href="<?php echo Yii::app()->baseUrl . '/wallet/search/' . $deudor['id']; ?>">
                          <?php echo $deudor['legalName']; ?>  
                        </a>
                      </td>
                      <td><?php echo $deudor['idNumber']; ?></td>
                      <td><?php echo $deudor['ciudad']; ?></td>
                      <td><?php echo $deudor['updateAt']; ?></td>
                      <td><?php echo Yii::app()->format->formatNumber($deudor['capitalValue']); ?></td>
                      <td><?php echo Yii::app()->format->formatNumber($deudor['saldo']); ?></td>
                      <td><?php echo $deudor['clasificacion']; ?></td>
                      <td><?php echo $deudor['edad']; ?></td>
                      <td><?php echo $deudor['status']; ?></td>
                    </tr>
                  <?php endforeach ?>
                <?php endif ?>
              </tbody>
            </table>
          </div>


        </section>

        <div class="clear"></div>
      </section>
    </div>
  </section>
  <div class="clear"></div>
</section>

<script>
  $(document).ready(function() {
    var table = $('#example').DataTable({paging: false, info: false});
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map(function(i) {
      $('#column'+i+'_search').on( 'keyup', function () {
        table.columns(i).search(this.value).draw();
      });
    })
  });
</script>