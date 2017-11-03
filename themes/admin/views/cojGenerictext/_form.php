<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'coj-generictext-form',
	'enableAjaxValidation' => true,
        'htmlOptions' => array('class'=>'well', 'onsubmit'=>'$(".upprogress").show();$(".submit-form").button("loading");'),
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Campos con'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'son requeridos'); ?>.
	</p>

	<?php echo $form->errorSummary($model, '<button type="button" class="close" data-dismiss="alert">&times;</button>', null, array('class'=>'alert alert-danger')); ?>
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12">
            <?php echo $form->labelEx($model,'text_es'); ?>
            <?php echo $form->textArea($model, 'text_es', array('class'=>'form-control input-block-level', 'rows' => 6, 'cols' => 50)); ?>
            <?php echo $form->error($model,'text_es'); ?>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12">
            <?php echo $form->labelEx($model,'text_en'); ?>
            <?php echo $form->textArea($model, 'text_en', array('class'=>'form-control input-block-level', 'rows' => 6, 'cols' => 50)); ?>
            <?php echo $form->error($model,'text_en'); ?>
            </div>
        </div>
        <hr/>
        <div class="row buttons text-center">
        <?php
            echo GxHtml::submitButton($model->isNewRecord ? Yii::t('app', 'Crear') : Yii::t('app', 'Guardar') , array('class'=>'btn btn-success btn-lg submit-form', 'data-loading-text'=>Yii::t('app', 'Guardando...')));
        ?>
        </div>
        <?php
            $this->endWidget();
        ?>
</div><!-- form -->