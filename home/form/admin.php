<?php
require_once( dirname(__FILE__).'/form.lib.php' );

define( 'PHPFMG_USER', "info@productospadel.com.co" ); // must be a email address. for sending password to you.
define( 'PHPFMG_PW', "d12207" );

?>
<?php
/**
 * GNU Library or Lesser General Public License version 2.0 (LGPLv2)
*/

# main
# ------------------------------------------------------
error_reporting( E_ERROR ) ;
phpfmg_admin_main();
# ------------------------------------------------------




function phpfmg_admin_main(){
    $mod  = isset($_REQUEST['mod'])  ? $_REQUEST['mod']  : '';
    $func = isset($_REQUEST['func']) ? $_REQUEST['func'] : '';
    $function = "phpfmg_{$mod}_{$func}";
    if( !function_exists($function) ){
        phpfmg_admin_default();
        exit;
    };

    // no login required modules
    $public_modules   = false !== strpos('|captcha|', "|{$mod}|", "|ajax|");
    $public_functions = false !== strpos('|phpfmg_ajax_submit||phpfmg_mail_request_password||phpfmg_filman_download||phpfmg_image_processing||phpfmg_dd_lookup|', "|{$function}|") ;   
    if( $public_modules || $public_functions ) { 
        $function();
        exit;
    };
    
    return phpfmg_user_isLogin() ? $function() : phpfmg_admin_default();
}

function phpfmg_ajax_submit(){
    $phpfmg_send = phpfmg_sendmail( $GLOBALS['form_mail'] );
    $isHideForm  = isset($phpfmg_send['isHideForm']) ? $phpfmg_send['isHideForm'] : false;

    $response = array(
        'ok' => $isHideForm,
        'error_fields' => isset($phpfmg_send['error']) ? $phpfmg_send['error']['fields'] : '',
        'OneEntry' => isset($GLOBALS['OneEntry']) ? $GLOBALS['OneEntry'] : '',
    );
    
    @header("Content-Type:text/html; charset=$charset");
    echo "<html><body><script>
    var response = " . json_encode( $response ) . ";
    try{
        parent.fmgHandler.onResponse( response );
    }catch(E){};
    \n\n";
    echo "\n\n</script></body></html>";

}


function phpfmg_admin_default(){
    if( phpfmg_user_login() ){
        phpfmg_admin_panel();
    };
}



function phpfmg_admin_panel()
{    
    phpfmg_admin_header();
    phpfmg_writable_check();
?>    
<table cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td valign=top style="padding-left:280px;">

<style type="text/css">
    .fmg_title{
        font-size: 16px;
        font-weight: bold;
        padding: 10px;
    }
    
    .fmg_sep{
        width:32px;
    }
    
    .fmg_text{
        line-height: 150%;
        vertical-align: top;
        padding-left:28px;
    }

</style>

<script type="text/javascript">
    function deleteAll(n){
        if( confirm("Are you sure you want to delete?" ) ){
            location.href = "admin.php?mod=log&func=delete&file=" + n ;
        };
        return false ;
    }
</script>


<div class="fmg_title">
    1. Email Traffics
</div>
<div class="fmg_text">
    <a href="admin.php?mod=log&func=view&file=1">view</a> &nbsp;&nbsp;
    <a href="admin.php?mod=log&func=download&file=1">download</a> &nbsp;&nbsp;
    <?php 
        if( file_exists(PHPFMG_EMAILS_LOGFILE) ){
            echo '<a href="#" onclick="return deleteAll(1);">delete all</a>';
        };
    ?>
</div>


<div class="fmg_title">
    2. Form Data
</div>
<div class="fmg_text">
    <a href="admin.php?mod=log&func=view&file=2">view</a> &nbsp;&nbsp;
    <a href="admin.php?mod=log&func=download&file=2">download</a> &nbsp;&nbsp;
    <?php 
        if( file_exists(PHPFMG_SAVE_FILE) ){
            echo '<a href="#" onclick="return deleteAll(2);">delete all</a>';
        };
    ?>
</div>

<div class="fmg_title">
    3. Form Generator
</div>
<div class="fmg_text">
    <a href="http://www.formmail-maker.com/generator.php" onclick="document.frmFormMail.submit(); return false;" title="<?php echo htmlspecialchars(PHPFMG_SUBJECT);?>">Edit Form</a> &nbsp;&nbsp;
    <a href="http://www.formmail-maker.com/generator.php" >New Form</a>
</div>
    <form name="frmFormMail" action='http://www.formmail-maker.com/generator.php' method='post' enctype='multipart/form-data'>
    <input type="hidden" name="uuid" value="<?php echo PHPFMG_ID; ?>">
    <input type="hidden" name="external_ini" value="<?php echo function_exists('phpfmg_formini') ?  phpfmg_formini() : ""; ?>">
    </form>

		</td>
	</tr>
</table>

<?php
    phpfmg_admin_footer();
}



function phpfmg_admin_header( $title = '' ){
    header( "Content-Type: text/html; charset=" . PHPFMG_CHARSET );
?>
<html>
<head>
    <title><?php echo '' == $title ? '' : $title . ' | ' ; ?>PHP FormMail Admin Panel </title>
    <meta name="keywords" content="PHP FormMail Generator, PHP HTML form, send html email with attachment, PHP web form,  Free Form, Form Builder, Form Creator, phpFormMailGen, Customized Web Forms, phpFormMailGenerator,formmail.php, formmail.pl, formMail Generator, ASP Formmail, ASP form, PHP Form, Generator, phpFormGen, phpFormGenerator, anti-spam, web hosting">
    <meta name="description" content="PHP formMail Generator - A tool to ceate ready-to-use web forms in a flash. Validating form with CAPTCHA security image, send html email with attachments, send auto response email copy, log email traffics, save and download form data in Excel. ">
    <meta name="generator" content="PHP Mail Form Generator, phpfmg.sourceforge.net">

    <style type='text/css'>
    body, td, label, div, span{
        font-family : Verdana, Arial, Helvetica, sans-serif;
        font-size : 12px;
    }
    </style>
</head>
<body  marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<table cellspacing=0 cellpadding=0 border=0 width="100%">
    <td nowrap align=center style="background-color:#024e7b;padding:10px;font-size:18px;color:#ffffff;font-weight:bold;width:250px;" >
        Form Admin Panel
    </td>
    <td style="padding-left:30px;background-color:#86BC1B;width:100%;font-weight:bold;" >
        &nbsp;
<?php
    if( phpfmg_user_isLogin() ){
        echo '<a href="admin.php" style="color:#ffffff;">Main Menu</a> &nbsp;&nbsp;' ;
        echo '<a href="admin.php?mod=user&func=logout" style="color:#ffffff;">Logout</a>' ;
    }; 
?>
    </td>
</table>

<div style="padding-top:28px;">

<?php
    
}


function phpfmg_admin_footer(){
?>

</div>

<div style="color:#cccccc;text-decoration:none;padding:18px;font-weight:bold;">
	:: <a href="http://phpfmg.sourceforge.net" target="_blank" title="Free Mailform Maker: Create read-to-use Web Forms in a flash. Including validating form with CAPTCHA security image, send html email with attachments, send auto response email copy, log email traffics, save and download form data in Excel. " style="color:#cccccc;font-weight:bold;text-decoration:none;">PHP FormMail Generator</a> ::
</div>

</body>
</html>
<?php
}


function phpfmg_image_processing(){
    $img = new phpfmgImage();
    $img->out_processing_gif();
}


# phpfmg module : captcha
# ------------------------------------------------------
function phpfmg_captcha_get(){
    $img = new phpfmgImage();
    $img->out();
    //$_SESSION[PHPFMG_ID.'fmgCaptchCode'] = $img->text ;
    $_SESSION[ phpfmg_captcha_name() ] = $img->text ;
}



function phpfmg_captcha_generate_images(){
    for( $i = 0; $i < 50; $i ++ ){
        $file = "$i.png";
        $img = new phpfmgImage();
        $img->out($file);
        $data = base64_encode( file_get_contents($file) );
        echo "'{$img->text}' => '{$data}',\n" ;
        unlink( $file );
    };
}


function phpfmg_dd_lookup(){
    $paraOk = ( isset($_REQUEST['n']) && isset($_REQUEST['lookup']) && isset($_REQUEST['field_name']) );
    if( !$paraOk )
        return;
        
    $base64 = phpfmg_dependent_dropdown_data();
    $data = @unserialize( base64_decode($base64) );
    if( !is_array($data) ){
        return ;
    };
    
    
    foreach( $data as $field ){
        if( $field['name'] == $_REQUEST['field_name'] ){
            $nColumn = intval($_REQUEST['n']);
            $lookup  = $_REQUEST['lookup']; // $lookup is an array
            $dd      = new DependantDropdown(); 
            echo $dd->lookupFieldColumn( $field, $nColumn, $lookup );
            return;
        };
    };
    
    return;
}


function phpfmg_filman_download(){
    if( !isset($_REQUEST['filelink']) )
        return ;
        
    $info =  @unserialize(base64_decode($_REQUEST['filelink']));
    if( !isset($info['recordID']) ){
        return ;
    };
    
    $file = PHPFMG_SAVE_ATTACHMENTS_DIR . $info['recordID'] . '-' . $info['filename'];
    phpfmg_util_download( $file, $info['filename'] );
}


class phpfmgDataManager
{
    var $dataFile = '';
    var $columns = '';
    var $records = '';
    
    function phpfmgDataManager(){
        $this->dataFile = PHPFMG_SAVE_FILE; 
    }
    
    function parseFile(){
        $fp = @fopen($this->dataFile, 'rb');
        if( !$fp ) return false;
        
        $i = 0 ;
        $phpExitLine = 1; // first line is php code
        $colsLine = 2 ; // second line is column headers
        $this->columns = array();
        $this->records = array();
        $sep = chr(0x09);
        while( !feof($fp) ) { 
            $line = fgets($fp);
            $line = trim($line);
            if( empty($line) ) continue;
            $line = $this->line2display($line);
            $i ++ ;
            switch( $i ){
                case $phpExitLine:
                    continue;
                    break;
                case $colsLine :
                    $this->columns = explode($sep,$line);
                    break;
                default:
                    $this->records[] = explode( $sep, phpfmg_data2record( $line, false ) );
            };
        }; 
        fclose ($fp);
    }
    
    function displayRecords(){
        $this->parseFile();
        echo "<table border=1 style='width=95%;border-collapse: collapse;border-color:#cccccc;' >";
        echo "<tr><td>&nbsp;</td><td><b>" . join( "</b></td><td>&nbsp;<b>", $this->columns ) . "</b></td></tr>\n";
        $i = 1;
        foreach( $this->records as $r ){
            echo "<tr><td align=right>{$i}&nbsp;</td><td>" . join( "</td><td>&nbsp;", $r ) . "</td></tr>\n";
            $i++;
        };
        echo "</table>\n";
    }
    
    function line2display( $line ){
        $line = str_replace( array('"' . chr(0x09) . '"', '""'),  array(chr(0x09),'"'),  $line );
        $line = substr( $line, 1, -1 ); // chop first " and last "
        return $line;
    }
    
}
# end of class



# ------------------------------------------------------
class phpfmgImage
{
    var $im = null;
    var $width = 73 ;
    var $height = 33 ;
    var $text = '' ; 
    var $line_distance = 8;
    var $text_len = 4 ;

    function phpfmgImage( $text = '', $len = 4 ){
        $this->text_len = $len ;
        $this->text = '' == $text ? $this->uniqid( $this->text_len ) : $text ;
        $this->text = strtoupper( substr( $this->text, 0, $this->text_len ) );
    }
    
    function create(){
        $this->im = imagecreate( $this->width, $this->height );
        $bgcolor   = imagecolorallocate($this->im, 255, 255, 255);
        $textcolor = imagecolorallocate($this->im, 0, 0, 0);
        $this->drawLines();
        imagestring($this->im, 5, 20, 9, $this->text, $textcolor);
    }
    
    function drawLines(){
        $linecolor = imagecolorallocate($this->im, 210, 210, 210);
    
        //vertical lines
        for($x = 0; $x < $this->width; $x += $this->line_distance) {
          imageline($this->im, $x, 0, $x, $this->height, $linecolor);
        };
    
        //horizontal lines
        for($y = 0; $y < $this->height; $y += $this->line_distance) {
          imageline($this->im, 0, $y, $this->width, $y, $linecolor);
        };
    }
    
    function out( $filename = '' ){
        if( function_exists('imageline') ){
            $this->create();
            if( '' == $filename ) header("Content-type: image/png");
            ( '' == $filename ) ? imagepng( $this->im ) : imagepng( $this->im, $filename );
            imagedestroy( $this->im ); 
        }else{
            $this->out_predefined_image(); 
        };
    }

    function uniqid( $len = 0 ){
        $md5 = md5( uniqid(rand()) );
        return $len > 0 ? substr($md5,0,$len) : $md5 ;
    }
    
    function out_predefined_image(){
        header("Content-type: image/png");
        $data = $this->getImage(); 
        echo base64_decode($data);
    }
    
    // Use predefined captcha random images if web server doens't have GD graphics library installed  
    function getImage(){
        $images = array(
			'A53D' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaklEQVR4nGNYhQEaGAYTpIn7GB1EQxmB0AFJjDVApIG10dEhAElMZIoIkAx0EEESC2gVCWEAqhNBcl/U0qlLV01dmTUNyX0BrQyNDgh1YBgaChTDNA+LGGsrulsCWhlD0N08UOFHRYjFfQCK0czO606bDwAAAABJRU5ErkJggg==',
			'BD3C' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAWklEQVR4nGNYhQEaGAYTpIn7QgNEQxhDGaYGIIkFTBFpZW10CBBBFmsVaXRoCHRgQVXX6NDo6IDsvtCoaSuzpq7MQnYfmjoU87CJodmB4RZsbh6o8KMixOI+ABgCzoRe0K38AAAAAElFTkSuQmCC',
			'5CE7' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaUlEQVR4nGNYhQEaGAYTpIn7QkMYQ1lDHUNDkMQCGlgbXYG0CIqYSAO6WGCASAMrWA7hvrBp01YtDV21MgvZfa1gda0oNkPEpiCLBbSC7QhAFhOZAnILowOyGGsA2M0oYgMVflSEWNwHAGJMy/RtCcAnAAAAAElFTkSuQmCC',
			'F5F1' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAWklEQVR4nGNYhQEaGAYTpIn7QkNFQ1lDA1qRxQIaRBpYGximYhELRRMLAYrB9IKdFBo1denS0FVLkd0X0MDQ6IpQh0dMBIsYaysrhhgjyN7QgEEQflSEWNwHABfTzQDpgN2BAAAAAElFTkSuQmCC',
			'86F8' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAYklEQVR4nGNYhQEaGAYTpIn7WAMYQ1hDA6Y6IImJTGFtZW1gCAhAEgtoFWlkbWB0EEFRJ9KApA7spKVR08KWhq6amoXkPpEpoljNc0UzD5sYNreA3dzAgOLmgQo/KkIs7gMApE7LyFXjtkMAAAAASUVORK5CYII=',
			'DDF3' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAWElEQVR4nGNYhQEaGAYTpIn7QgNEQ1hDA0IdkMQCpoi0sjYwOgQgi7WKNLoCaREsYgFI7otaOm1lauiqpVlI7kNTR9A8FDEsbgG7uYEBxc0DFX5UhFjcBwCX4c7ezewQ+wAAAABJRU5ErkJggg==',
			'192E' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAb0lEQVR4nGNYhQEaGAYTpIn7GB0YQxhCGUMDkMRYHVhbGR0dHZDViTqINLo2BDqg6hVpdECIgZ20Mmvp0qyVmaFZSO4D2hHo0MqIppeh0WEKuhhLo0MAuhjQLQ6oYqIhjCGsoYEobh6o8KMixOI+AIbSxs85S1CsAAAAAElFTkSuQmCC',
			'6ADA' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAcUlEQVR4nGNYhQEaGAYTpIn7WAMYAlhDGVqRxUSmMIawNjpMdUASC2hhbWVtCAgIQBZrEGl0bQh0EEFyX2TUtJWpqyKzpiG5L2QKijqI3lbRUKBYaAiKGKY6EZDeRkcUMdYAoFgoI4rYQIUfFSEW9wEAtHHNjdiTtwwAAAAASUVORK5CYII=',
			'2922' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAeUlEQVR4nM2QMQ6AMAhFIbE34EA4uNOkLB7BU9ChN6jewEFPaUeMjpqUP/ESwsuH8zEGPeUXvyCYQGFlx6iGgiOLOCaF8mSRyV83xiZG3m/b9+VYztn7CUYukP0P5LZXKDcXGzILVM/ImguDeKaKKWjU1EF/H+bF7wKJhMuDWFBRdgAAAABJRU5ErkJggg==',
			'2628' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAd0lEQVR4nM2QwQ2AMAhF4cAGuA9ugEnrEE5RD2xQ3cFOqcaYlOhRo/wTP/yfF6BcJsGf9AofKQaIMEnlcSbDVlQrT41HSp1wnbZ90/PuYJrnvizDNNR82hgYuD4UHiWj66O0eeo9ThuL+GyMGCiqY/7qfw/qhm8FvDTLAu6ewdQAAAAASUVORK5CYII=',
			'BA6F' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaklEQVR4nGNYhQEaGAYTpIn7QgMYAhhCGUNDkMQCpjCGMDo6OiCrC2hlbWVtQBObItLo2sAIEwM7KTRq2srUqStDs5DcB1aHYZ5oqGtDIJoYyLxADDsc0fSGBog0OoQyoogNVPhREWJxHwB6Y8vQpFNkdgAAAABJRU5ErkJggg==',
			'E4E1' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAXElEQVR4nGNYhQEaGAYTpIn7QkMYWllDHVqRxQIaGKayAjGaWChQLBRVjNEVKAbTC3ZSaNTSpUtDVy1Fdl9Ag0grkjqomGioK4YYAxZ1mGJQN4cGDILwoyLE4j4AKqbMRE4rbZQAAAAASUVORK5CYII=',
			'C880' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAX0lEQVR4nGNYhQEaGAYTpIn7WEMYQxhCGVqRxURaWVsZHR2mOiCJBTSKNLo2BAQEIIs1gNQ5OogguS9q1cqwVaErs6YhuQ9NHVQMZF4gqhgWO7C5BZubByr8qAixuA8AV5vMYVR9y2oAAAAASUVORK5CYII=',
			'CF85' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZ0lEQVR4nGNYhQEaGAYTpIn7WENEQx1CGUMDkMREWkUaGB0dHZDVBTSKNLA2BKKKNYDVuToguS9q1dSwVaEro6KQ3AdR5wAkUfWygklMO0Qw3OIQgOw+1hCgilCGqQ6DIPyoCLG4DwBLu8unV0CgegAAAABJRU5ErkJggg==',
			'D4E6' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZ0lEQVR4nGNYhQEaGAYTpIn7QgMYWllDHaY6IIkFTGGYytrAEBCALNbKEMrawOgggCLG6AoSQ3Zf1FIgCF2ZmoXkvoBWkVagOjTzRENdgXpFUO0AqUMVmwISQ3ULNjcPVPhREWJxHwBg08xmQeVRjAAAAABJRU5ErkJggg==',
			'32D1' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAbElEQVR4nGNYhQEaGAYTpIn7RAMYQ1hDGVqRxQKmsLayNjpMRVHZKtLo2hAQiiI2hQEkBtMLdtLKqFVLl66KWorivikMU1gR6qDmMQRgijE6oIsB3dIAdAuKmGiAaKhrKENowCAIPypCLO4DANwtzL3Kn6GeAAAAAElFTkSuQmCC',
			'D9C5' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaUlEQVR4nGNYhQEaGAYTpIn7QgMYQxhCHUMDkMQCprC2MjoEOiCrC2gVaXRtEMQixujqgOS+qKVLl6auWhkVheS+gFbGQFcgLYKil6ERU4wFbAeKGNgtAQHI7oO42WGqwyAIPypCLO4DAIMHzWD5RC5nAAAAAElFTkSuQmCC',
			'E05D' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZ0lEQVR4nGNYhQEaGAYTpIn7QkMYAlhDHUMdkMQCGhhDWBsYHQJQxFhbQWIiKGIija5T4WJgJ4VGTVuZmpmZNQ3JfSB1Dg2BGHoxxUB2oIsxhjA6OqK4BeRmhlBGFDcPVPhREWJxHwCzDcvQ7h008QAAAABJRU5ErkJggg==',
			'3E93' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAYElEQVR4nGNYhQEaGAYTpIn7RANEQxmA0AFJLGCKSAOjo6NDALLKVpEG1oaABhFksSkQsQAk962Mmhq2MjNqaRay+4DqGELg6uDmMaCbBxRjRBPD5hZsbh6o8KMixOI+ABnUzCL/a4znAAAAAElFTkSuQmCC',
			'0A7F' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAa0lEQVR4nGNYhQEaGAYTpIn7GB0YAlhDA0NDkMRYAxhDGBoCHZDViUxhbUUXC2gVaXRodISJgZ0UtXTayqylK0OzkNwHVjeFEU2vaKhDACOaHSJA01DFWANEGl0bUMUYHTDFBir8qAixuA8Aa1fJ6eTCM4wAAAAASUVORK5CYII=',
			'018A' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAbUlEQVR4nGNYhQEaGAYTpIn7GB0YAhhCGVqRxVgDGAMYHR2mOiCJiUxhDWBtCAgIQBILaGUAqnN0EEFyX9TSVVGrQldmTUNyH5o6uBhrQ2BoCIodYDEUdawBmHoZHVhDGUIZUcQGKvyoCLG4DwB+cchPAIWxdgAAAABJRU5ErkJggg==',
			'AC9A' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAc0lEQVR4nGNYhQEaGAYTpIn7GB0YQxlCGVqRxVgDWBsdHR2mOiCJiUwRaXBtCAgIQBILaBVpYG0IdBBBcl/U0mmrVmZGZk1Dch9IHUMIXB0YhoaCeIGhIWjmOTagqgtoBbnFEU0M5GZGFLGBCj8qQizuAwB/6syMZQBbUgAAAABJRU5ErkJggg==',
			'DB6A' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZ0lEQVR4nGNYhQEaGAYTpIn7QgNEQxhCGVqRxQKmiLQyOjpMdUAWaxVpdG1wCAhAFWtlbWB0EEFyX9TSqWFLp67MmobkPrA6R0eYOiTzAkNDMMVQ1YHdgqoX4mZGFLGBCj8qQizuAwD6PM19BaZI4AAAAABJRU5ErkJggg==',
			'A8F4' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaUlEQVR4nGNYhQEaGAYTpIn7GB0YQ1hDAxoCkMRYA1hbWRsYGpHFRKaINLo2MLQiiwW0gtVNCUByX9TSlWFLQ1dFRSG5D6KO0QFZb2goyDzG0BAU88B2NGCxA00M6GY0sYEKPypCLO4DAOj3zdpG4jgQAAAAAElFTkSuQmCC',
			'F3CE' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAWUlEQVR4nGNYhQEaGAYTpIn7QkNZQxhCHUMDkMQCGkRaGR0CHRhQxBgaXRsE0cVaWRsYYWJgJ4VGrQpbumplaBaS+9DUIZmHTQzdDmxuwXTzQIUfFSEW9wEA0tTLJDuC4cQAAAAASUVORK5CYII=',
			'B63C' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAYUlEQVR4nGNYhQEaGAYTpIn7QgMYQxhDGaYGIIkFTGFtZW10CBBBFmsVaWRoCHRgQVEHVNHo6IDsvtCoaWGrpq7MQnZfwBTRViR1cPMcgOZhE0O1A9Mt2Nw8UOFHRYjFfQCqPM1vafo5VgAAAABJRU5ErkJggg==',
			'CC5F' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZUlEQVR4nGNYhQEaGAYTpIn7WEMYQ1lDHUNDkMREWlkbXRsYHZDVBTSKNGCINYg0sE6Fi4GdFLVq2qqlmZmhWUjuA6ljaAjE0IshBrYDVQzkFkdHRxQxkJsZQlHdMlDhR0WIxX0AVarKk6RnJhgAAAAASUVORK5CYII=',
			'F2F9' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAa0lEQVR4nGNYhQEaGAYTpIn7QkMZQ1hDA6Y6IIkFNLC2sjYwBASgiIk0ujYwOoigiDEgi4GdFBq1aunS0FVRYUjuA6qbAjRvKpreAKBYA6oYowNQDM0O1gZMt4iGugLNQ3bzQIUfFSEW9wEAnlLMh8sVRrAAAAAASUVORK5CYII=',
			'677F' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaUlEQVR4nGNYhQEaGAYTpIn7WANEQ11DA0NDkMREpjA0OjQEOiCrC2jBItbA0MrQ6AgTAzspMmrVtFVLV4ZmIbkvZApDAMMURlS9rUB+ALoYawOjA6qYyBSRBpAoqpsxxQYq/KgIsbgPABFeygCxTu+8AAAAAElFTkSuQmCC',
			'D4F1' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAYElEQVR4nGNYhQEaGAYTpIn7QgMYWllDA1qRxQKmMExlbWCYiiLWyhAKFAtFFWN0BYrB9IKdFLUUCEJXLUV2X0CrSCuSOqiYaKgrhhgDpropmGJgNwPdEjAIwo+KEIv7AOFrzMgJQW8LAAAAAElFTkSuQmCC',
			'9B90' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaUlEQVR4nGNYhQEaGAYTpIn7WANEQxhCGVqRxUSmiLQyOjpMdUASC2gVaXRtCAgIQBVrZW0IdBBBct+0qVPDVmZGZk1Dch+rq0grQwhcHQQCzXNoQBUTAIo5otmBzS3Y3DxQ4UdFiMV9AB+pzBmGcNWCAAAAAElFTkSuQmCC',
			'E169' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAY0lEQVR4nGNYhQEaGAYTpIn7QkMYAhhCGaY6IIkFNDAGMDo6BASgiLEGsDY4OoigiDEAxRhhYmAnhUatilo6dVVUGJL7wOocHaZi6g1owCKGYQe6W0JDWEPR3TxQ4UdFiMV9AEjPysEubyqoAAAAAElFTkSuQmCC',
			'BBB1' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAVElEQVR4nGNYhQEaGAYTpIn7QgNEQ1hDGVqRxQKmiLSyNjpMRRFrFWl0bQgIxaIOphfspNCoqWFLQ1ctRXYfmjpk8wiLYdELdXNowCAIPypCLO4DAGznzt5jtP9MAAAAAElFTkSuQmCC',
			'CEC6' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAXklEQVR4nGNYhQEaGAYTpIn7WENEQxlCHaY6IImJtIo0MDoEBAQgiQU0ijSwNgg6CCCLNYDEGB2Q3Re1amrY0lUrU7OQ3AdVh2oeVK8IFjtECLgFm5sHKvyoCLG4DwB4d8ujCtksKQAAAABJRU5ErkJggg==',
			'1564' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAc0lEQVR4nGNYhQEaGAYTpIn7GB1EQxlCGRoCkMRYHUQaGB0dGpHFRIFirA0OrQEoekVCWBsYpgQguW9l1tSlS6euiopCch+jA0Ojq6OjA6peoFhDYGgIqnlAsYAGVHWsrUC3oIiJhjCGoLt5oMKPihCL+wCjRssWvk82LQAAAABJRU5ErkJggg==',
			'4BB2' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaUlEQVR4nGNYhQEaGAYTpI37poiGsIYyTHVAFgsRaWVtdAgIQBJjDBFpdG0IdBBBEmOdAlbXIILkvmnTpoYtDV21KgrJfQEQdY3IdoSGgswLaEV1C1hsCpoY2C2YbmYMDRkM4Uc9iMV9AIqPzVxG9KYuAAAAAElFTkSuQmCC',
			'ADB1' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAY0lEQVR4nGNYhQEaGAYTpIn7GB1EQ1hDGVqRxVgDRFpZGx2mIouJTBFpdG0ICEUWC2gFijU6wPSCnRS1dNrK1NBVS5Hdh6YODENDwea1YpiHKQZyC5oY2M2hAYMg/KgIsbgPAI8LznLXiNoLAAAAAElFTkSuQmCC',
			'33DE' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAV0lEQVR4nGNYhQEaGAYTpIn7RANYQ1hDGUMDkMQCpoi0sjY6OqCobGVodG0IRBWbwtDKihADO2ll1KqwpasiQ7OQ3YeqDrd5WMSwuQWbmwcq/KgIsbgPAEIyyqt/PRrvAAAAAElFTkSuQmCC',
			'811E' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAXUlEQVR4nGNYhQEaGAYTpIn7WAMYAhimMIYGIImJTGEMYAhhdEBWF9DKGsCIJiYyBawXJgZ20tKoVVGrpq0MzUJyH5o6qHnEiWHTyxrAGsoY6oji5oEKPypCLO4DABgVx2mGeunAAAAAAElFTkSuQmCC',
			'220A' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAeElEQVR4nM2QsQ2AMAwEP0U2CPs4Bb2RcMEKTAGFNwhsQJMpiWhwBCUI/N3pLZ+MfJkJf8orfp5djwS1LCSvECxkGGuYYyRmu62Y26mjYP3WvG15GFfrx0j+7B1xBC5MeutSqCtHbC8UCnEVE2mEUs2++t+DufHbAXmKyphjzUS2AAAAAElFTkSuQmCC',
			'0895' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAcUlEQVR4nGNYhQEaGAYTpIn7GB0YQxhCGUMDkMRYA1hbGR0dHZDViUwRaXRtCEQRC2hlbWVtCHR1QHJf1NKVYSszI6OikNwHUscQEtAggqJXpNGhAVUMZIcj0A4RDLc4BCC7D+JmhqkOgyD8qAixuA8AW3jK8XRJRuMAAAAASUVORK5CYII=',
			'A7C7' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAdUlEQVR4nGNYhQEaGAYTpIn7GB1EQx1CHUNDkMRYAxgaHR0CGkSQxESmMDS6NgigiAW0MrSygmgk90UtXTVt6apVK7OQ3AdUFwBU14psb2goowNQbAoDinmsDawNAgGoYiJANwY6oIsxhDqiiA1U+FERYnEfAEijzCgMfGzIAAAAAElFTkSuQmCC',
			'6ED5' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAYklEQVR4nGNYhQEaGAYTpIn7WANEQ1lDGUMDkMREpog0sDY6OiCrC2gBijUEooo1gMVcHZDcFxk1NWwpkIxCcl8IyDywaiS9rbjEAh1EMNziEIDsPoibGaY6DILwoyLE4j4AKQrMXuoDMUEAAAAASUVORK5CYII=',
			'9DF5' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZElEQVR4nGNYhQEaGAYTpIn7WANEQ1hDA0MDkMREpoi0sjYwOiCrC2gVaXTFLubqgOS+aVOnrUwNXRkVheQ+VleQOqC5yDa3YooJQO1AFoO4hSEA2X1gNzcwTHUYBOFHRYjFfQAzqctzYI0iJQAAAABJRU5ErkJggg==',
			'C1FB' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAXklEQVR4nGNYhQEaGAYTpIn7WEMYAlhDA0MdkMREWhkDWBsYHQKQxAIaWcFiIshiDQzI6sBOigKipaErQ7OQ3IemDkUMxbxGTDGRVky9rCGsoUAxFDcPVPhREWJxHwAAtcjMFkR/nQAAAABJRU5ErkJggg==',
			'050A' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAdUlEQVR4nM2QsQ2AMAwE30U2MPs4Bb2RkgJGYIpQZIPABmmYkhJHUILA351e+pOxXy7hT3nFj6SLKMiWOeWEiFUM48KJvKgappmDS4Ow8ZvqWus+zpvx04ylP3uWxdBuLN77pufUZURqGAkFlJZ99b8Hc+N3AM9EyvndBvsvAAAAAElFTkSuQmCC',
			'EE0E' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAU0lEQVR4nGNYhQEaGAYTpIn7QkNEQxmmMIYGIIkFNIg0MIQyOjCgiTE6OmKIsTYEwsTATgqNmhq2dFVkaBaS+9DU4RXDZge6W7C5eaDCj4oQi/sALnzKluks/RwAAAAASUVORK5CYII=',
			'1980' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZklEQVR4nGNYhQEaGAYTpIn7GB0YQxhCGVqRxVgdWFsZHR2mOiCJiTqINLo2BAQEoOgVaXR0dHQQQXLfyqylS7NCV2ZNQ3If0I5AJHVQMQageYFoYixY7MDilhBMNw9U+FERYnEfAGpgyT3VJfj9AAAAAElFTkSuQmCC',
			'9208' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAdklEQVR4nGNYhQEaGAYTpIn7WAMYQximMEx1QBITmcLayhDKEBCAJBbQKtLo6OjoIIIixtDo2hAAUwd20rSpq5YuXRU1NQvJfayuDFNYEeogsJUhgLUhEMU8gVZGB0Y0O4BuaUB3C2uAaKgDmpsHKvyoCLG4DwDHtsu8yjtvvAAAAABJRU5ErkJggg==',
			'875E' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAbElEQVR4nGNYhQEaGAYTpIn7WANEQ11DHUMDkMREpjA0ujYwOiCrC2jFFAOqa2WdChcDO2lp1KppSzMzQ7OQ3AdUF8DQEIhmHkgfuhhrAyuamMgUkQZGR0cUMdYAkQaGUEYUNw9U+FERYnEfALbzyhVvmKsaAAAAAElFTkSuQmCC',
			'5683' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZklEQVR4nGNYhQEaGAYTpIn7QkMYQxhCGUIdkMQCGlhbGR0dHQJQxEQaWUEkklhggEgDo6NDQwCS+8KmTQtbFbpqaRay+1pFW5HUQcVEGl3RzAvAIiYyBdMtrAGYbh6o8KMixOI+AMvozKXXYS/WAAAAAElFTkSuQmCC',
			'41EC' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAYklEQVR4nGNYhQEaGAYTpI37pjAEsIY6TA1AFgthDGBtYAgQQRJjDGEFijE6sCCJsYL0AsWQ3Tdt2qqopaErs5DdF4CqDgxDQzHFGKDqWDDEUN3CMIU1FMPNAxV+1INY3AcAtXrH6MWvDFkAAAAASUVORK5CYII=',
			'EE7F' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAVklEQVR4nGNYhQEaGAYTpIn7QkNEQ1lDA0NDkMQCGkSAZKADAzFijY4wMbCTQqOmhq1aujI0C8l9YHVTGDH1BmCKMTpgirE2oIqB3YwmNlDhR0WIxX0Abe7KarUXIykAAAAASUVORK5CYII=',
			'3B21' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZElEQVR4nGNYhQEaGAYTpIn7RANEQxhCGVqRxQKmiLQyOjpMRVHZKtLo2hAQiiIGVAdUDdMLdtLKqKlhq1ZmLUVxH0hdK6odIPMcpmARC8DiFgdUMZCbWUMDQgMGQfhREWJxHwCjFcvAFIr4xAAAAABJRU5ErkJggg==',
			'EF9C' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAW0lEQVR4nGNYhQEaGAYTpIn7QkNEQx1CGaYGIIkFNIg0MDo6BIigibE2BDqwYBFDdl9o1NSwlZmRWcjuA6ljCIGrQ4g1YIoxYrED3S2hIUAempsHKvyoCLG4DwAxtcws8HiQuwAAAABJRU5ErkJggg==',
			'0931' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZ0lEQVR4nGNYhQEaGAYTpIn7GB0YQxhDGVqRxVgDWFtZGx2mIouJTBFpdGgICEUWC2gFijU6wPSCnRS1dOnSrKmrliK7L6CVMRBJHVSMAWReK6odLBhiULegiEHdHBowCMKPihCL+wD2sMzeSCDhUgAAAABJRU5ErkJggg==',
			'6483' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAbUlEQVR4nGNYhQEaGAYTpIn7WAMYWhlCGUIdkMREpjBMZXR0dAhAEgtoYQhlbQhoEEEWa2B0ZXR0aAhAcl9k1NKlq0JXLc1Ccl/IFJFWJHUQva2ioa7o5rUytKLbAXRLK7pbsLl5oMKPihCL+wCHjcyQ/Dne0QAAAABJRU5ErkJggg==',
			'1444' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaUlEQVR4nGNYhQEaGAYTpIn7GB0YWhkaHRoCkMRYHRimMrQ6NCKLiTowhDJMdWgNQNHL6MoQ6DAlAMl9K7OWLl2ZmRUVheQ+RgeRVtZGRwdUvaKhrqGBoSEE3IJNTDQEU2ygwo+KEIv7ADt7y4zjNrOaAAAAAElFTkSuQmCC',
			'BAE8' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAY0lEQVR4nGNYhQEaGAYTpIn7QgMYAlhDHaY6IIkFTGEMYW1gCAhAFmtlbWVtYHQQQVEn0uiKUAd2UmjUtJWpoaumZiG5D00d1DzRUFd081pB6vDaAXUzUAzNzQMVflSEWNwHAA/8zfc+Os4zAAAAAElFTkSuQmCC',
			'4ED2' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZklEQVR4nGNYhQEaGAYTpI37poiGsoYyTHVAFgsRaWBtdAgIQBJjBIk1BDqIIImxTgGJBTSIILlv2rSpYUtXRQEhwn0BEHWNyHaEhoLFWlHdAhabgiEGdAummxlDQwZD+FEPYnEfALSQzKp/D0t8AAAAAElFTkSuQmCC',
			'94AF' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaUlEQVR4nGNYhQEaGAYTpIn7WAMYWhmmMIaGIImJTGGYyhDK6ICsLqAVKOLoiCbG6MraEAgTAztp2tSlS5euigzNQnIfq6tIK5I6CGwVDXUNRRUTaGXAUAd0C4YYyM0Y5g1Q+FERYnEfAO4EyaZxkwKzAAAAAElFTkSuQmCC',
			'51D0' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZElEQVR4nGNYhQEaGAYTpIn7QkMYAlhDGVqRxQIaGANYGx2mOqCIsQawNgQEBCCJBQYA9TYEOogguS9s2qqopasis6Yhu68VRR1OsQCwGKodIlMYMNwCdEkoupsHKvyoCLG4DwC05crltR2TdwAAAABJRU5ErkJggg==',
			'530B' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaElEQVR4nGNYhQEaGAYTpIn7QkNYQximMIY6IIkFNIi0MoQyOgSgiDE0Ojo6OoggiQUGMLSyNgTC1IGdFDZtVdjSVZGhWcjua0VRBxNrdAWKIZsX0Ipph8gUTLewBmC6eaDCj4oQi/sARknLWZA0jRkAAAAASUVORK5CYII=',
			'F54B' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZUlEQVR4nGNYhQEaGAYTpIn7QkNFQxkaHUMdkMQCGkQaGFodHQLQxaY6OoigioUwBMLVgZ0UGjV16crMzNAsJPcB5RtdG9HNA4qFBqKb1+jQiG4HaysDhl7GEHQ3D1T4URFicR8AIwPN1ks3qEIAAAAASUVORK5CYII=',
			'0544' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAcElEQVR4nGNYhQEaGAYTpIn7GB1EQxkaHRoCkMRYA0QaGFodGpHFRKYAxaY6tCKLBbSKhDAEOkwJQHJf1NKpS1dmZkVFIbkvoJWh0bXR0QFVL1AsNDA0BNWORgcMt7C2oruP0YExBF1soMKPihCL+wD8cs6DeyzEXwAAAABJRU5ErkJggg==',
			'ADEE' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAWElEQVR4nGNYhQEaGAYTpIn7GB1EQ1hDHUMDkMRYA0RaWYEyyOpEpog0uqKJBbSiiIGdFLV02srU0JWhWUjuQ1MHhqGhBM2DiWG4JaAV080DFX5UhFjcBwAi9srTZDbrrwAAAABJRU5ErkJggg==',
			'9B93' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaElEQVR4nGNYhQEaGAYTpIn7WANEQxhCGUIdkMREpoi0Mjo6OgQgiQW0ijS6NgQ0iKCKtbICxQKQ3Ddt6tSwlZlRS7OQ3MfqKtLKEAJXB4FA8xzQzBMAijmiiWFzCzY3D1T4URFicR8AFg/M3tIdOgUAAAAASUVORK5CYII=',
			'4848' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAbUlEQVR4nGNYhQEaGAYTpI37pjCGMDQ6THVAFgthbWVodQgIQBJjDBEBqnJ0EEESY50CVBcIVwd20rRpK8NWZmZNzUJyXwBQHWsjqnmhoSKNrqGBKOYxTAHa0eiIJga0A00vVjcPVPhRD2JxHwA7v80qEmHDAwAAAABJRU5ErkJggg==',
			'4C4F' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAa0lEQVR4nGNYhQEaGAYTpI37pjCGMjQ6hoYgi4WwNjq0Ojogq2MMEWlwmIoqxjpFpIEhEC4GdtK0adNWrczMDM1Ccl8AUB1rI6re0FCgWGigA6pbgHagqWOYAnQLhhjYzahiAxV+1INY3AcAtvrK/j/DxYQAAAAASUVORK5CYII=',
			'39A0' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAcklEQVR4nGNYhQEaGAYTpIn7RAMYQximMLQiiwVMYW1lCGWY6oCsslWk0dHRISAAWWyKSKNrQ6CDCJL7VkYtXZq6KjJrGrL7pjAGIqmDmsfQ6BqKLsYCNC8AxQ6QW1gbAlDcAnIzUAzFzQMVflSEWNwHAOcFzPrdMvUUAAAAAElFTkSuQmCC',
			'2BAA' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAb0lEQVR4nGNYhQEaGAYTpIn7WANEQximMLQii4lMEWllCGWY6oAkFtAq0ujo6BAQgKy7VaSVtSHQQQTZfdOmhi1dFZk1Ddl9ASjqwJDRQaTRNTQwNATZLQ1AMTR1Ig2YekNDRUPQxQYq/KgIsbgPAOh4zAlX+wkOAAAAAElFTkSuQmCC',
			'471F' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZElEQVR4nGNYhQEaGAYTpI37poiGOkxhDA1BFgthaHQIYXRAVscIFHNEE2OdwtDKMAUuBnbStGmrgHBlaBaS+wKmMAQgqQPD0FAgH02MYQprA6aYCFYxxlBHVLGBCj/qQSzuAwAY58jXlup3lwAAAABJRU5ErkJggg==',
			'C6D7' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAa0lEQVR4nGNYhQEaGAYTpIn7WEMYQ1hDGUNDkMREWllbWRsdGkSQxAIaRRpZGwJQxYA8kFgAkvuiVk0LW7oqamUWkvsCGkRbgepaGVD1Nro2BExhQLMDKBbAgOEWRwcsbkYRG6jwoyLE4j4AeVvNDvH0btoAAAAASUVORK5CYII=',
			'ABAE' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAbElEQVR4nGNYhQEaGAYTpIn7GB1EQximMIYGIImxBoi0MoQyOiCrE5ki0ujo6IgiFtAq0sraEAgTAzspaunUsKWrIkOzkNyHpg4MQ0NFGl1DA9HNa3RtwBDD0BvQKhoCFENx80CFHxUhFvcBAOpzy7PBaFhLAAAAAElFTkSuQmCC',
			'CDE3' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAWElEQVR4nGNYhQEaGAYTpIn7WENEQ1hDHUIdkMREWkVaWRsYHQKQxAIaRRpdQXLIYg0QsQAk90WtmrYyNXTV0iwk96GpQxETIWAHNrdgc/NAhR8VIRb3AQD8WM2jUAUKGgAAAABJRU5ErkJggg==',
			'5DBE' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAXUlEQVR4nGNYhQEaGAYTpIn7QkNEQ1hDGUMDkMQCGkRaWRsdHRhQxRpdGwJRxAIDgGIIdWAnhU2btjI1dGVoFrL7WlHUIcTQzAvAIiYyBdMtrAGYbh6o8KMixOI+AP3Xy+kKRP3MAAAAAElFTkSuQmCC',
			'D501' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZUlEQVR4nGNYhQEaGAYTpIn7QgNEQxmmMLQiiwVMEWlgCGWYiiLWKtLA6OgQiiYWwgokkd0XtXTq0qVAEtl9QBWNrgh1eMREGh0dHdDcwtoKdAuKWGgAYwjQzaEBgyD8qAixuA8AOzXN6SAhbFIAAAAASUVORK5CYII=',
			'A9FA' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAb0lEQVR4nGNYhQEaGAYTpIn7GB0YQ1hDA1qRxVgDWFtZGximOiCJiUwRaXRtYAgIQBILaAWJMTqIILkvaunSpamhK7OmIbkvoJUxEEkdGIaGMoD0hoagmMfSiK4uoBXkFnQxoJvRxAYq/KgIsbgPAHW6y6f+ECv/AAAAAElFTkSuQmCC',
			'171E' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZUlEQVR4nGNYhQEaGAYTpIn7GB1EQx2mMIYGIImxOjA0OoQwOiCrEwWKOaKJAXmtDFPgYmAnrcxaNW3VtJWhWUjuA6oIQFIHFQPyMcRYGzDFRDDERENEGhhDHVHcPFDhR0WIxX0AI07GiKSpnREAAAAASUVORK5CYII=',
			'F037' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAY0lEQVR4nGNYhQEaGAYTpIn7QkMZAhhDGUNDkMQCGhhDWBsdGkRQxFhbQSSqmEijA1BdAJL7QqOmrcyaumplFpL7oOpaGdD1NgRMYcC0I4ABwy2ODqhiYDejiA1U+FERYnEfAE4KzbOs/tPIAAAAAElFTkSuQmCC',
			'066E' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAYklEQVR4nGNYhQEaGAYTpIn7GB0YQxhCGUMDkMRYA1hbGR0dHZDViUwRaWRtQBULaBVpYAWagOy+qKXTwpZOXRmaheS+gFbRVlZHDL2Nrg2BGHagi2FzCzY3D1T4URFicR8AWc7JOS7SO4kAAAAASUVORK5CYII=',
			'DE57' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAYUlEQVR4nGNYhQEaGAYTpIn7QgNEQ1lDHUNDkMQCpog0sAJpEWSxVhxiU4E0kvuilk4NW5qZtTILyX0gdSCSAU0vyCZ0MdaGgAAUMaBbGB0dHdDdzBDKiCI2UOFHRYjFfQByjMzyCRiRRQAAAABJRU5ErkJggg==',
			'6B30' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZElEQVR4nGNYhQEaGAYTpIn7WANEQxhDGVqRxUSmiLSyNjpMdUASC2gRaXRoCAgIQBZrEGllaHR0EEFyX2TU1LBVU1dmTUNyX8gUFHUQva0g8wKxiKHagc0t2Nw8UOFHRYjFfQAo283TgzMVjwAAAABJRU5ErkJggg==',
			'B7A0' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAbklEQVR4nGNYhQEaGAYTpIn7QgNEQx2mMLQiiwVMYWh0CGWY6oAs1srQ6OjoEBCAqq6VtSHQQQTJfaFRq6YtXRWZNQ3JfUB1AUjqoOYxOrCGoouxNrA2BKDZIQISQ3FLaABYDMXNAxV+VIRY3AcAx9HOW5Xo8X8AAAAASUVORK5CYII=',
			'AF70' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAa0lEQVR4nGNYhQEaGAYTpIn7GB1EQ11DA1qRxVgDRIBkwFQHJDGRKWCxgAAksYBWoFijo4MIkvuilk4NW7V0ZdY0JPeB1U1hhKkDw9BQIC8AVQykjtGBAcMO1gYGFLdAxVDcPFDhR0WIxX0AzTbMtbw1eZ8AAAAASUVORK5CYII=',
			'3E40' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZklEQVR4nGNYhQEaGAYTpIn7RANEQxkaHVqRxQKmiDQwtDpMdUBW2QoUm+oQEIAsBlIX6OggguS+lVFTw1ZmZmZNQ3YfUB1rI1wd3DzW0EAMMaBbUOwAu6UR1S3Y3DxQ4UdFiMV9AHiYzG/V7xMMAAAAAElFTkSuQmCC',
			'722D' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAc0lEQVR4nGNYhQEaGAYTpIn7QkMZQxhCGUMdkEVbWVsZHR0dAlDERBpdGwIdRJDFpjA0OiDEIG6KWrV01crMrGlI7mN0AKpsZUTRy9rAEMAwBVVMBKQyAFUsAKiS0YERxS0BDaKhrqGBqG4eoPCjIsTiPgCxccosVMnaCwAAAABJRU5ErkJggg==',
			'0EFD' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAWElEQVR4nGNYhQEaGAYTpIn7GB1EQ1lDA0MdkMRYA0QaWIEyAUhiIlMgYiJIYgGtKGJgJ0UtnRq2NHRl1jQk96GpwymGzQ5sbgG7uYERxc0DFX5UhFjcBwDYncl84vA+WwAAAABJRU5ErkJggg==',
			'899E' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZElEQVR4nGNYhQEaGAYTpIn7WAMYQxhCGUMDkMREprC2Mjo6OiCrC2gVaXRtCEQRE5mCIgZ20tKopUszMyNDs5DcJzKFMdAhJBDNPIZGhwZ0MZZGRww7MN2Czc0DFX5UhFjcBwAJesp3+AdMggAAAABJRU5ErkJggg==',
			'2F2A' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAdElEQVR4nGNYhQEaGAYTpIn7WANEQx1CGVqRxUSmiDQwOjpMdUASC2gVaWBtCAgIQNYNFGNoCHQQQXbftKlhq1ZmZk1Ddl8AUEUrI0wdGIJ5UxhDQ5Dd0gAUC0BVJwKEjA6oYqGhQLeEBqKIDVT4URFicR8AITPKRDgE6XAAAAAASUVORK5CYII=',
			'7F39' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAaUlEQVR4nGNYhQEaGAYTpIn7QkNFQx1DGaY6IIu2ijSwNjoEBKCJMTQEOoggi00B8hodYWIQN0VNDVs1dVVUGJL7GEEqGh2mIutlbQDxAhqQxUQgYih2gFSguwUkxoju5gEKPypCLO4DAKGZzK7IjcV2AAAAAElFTkSuQmCC',
			'26A2' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAdklEQVR4nM2QsQ2AMAwEnSIbmH1CQf9IMQXTOIU3CGxAw5SEzghKkPB3J798Mu23UfpTPvGLCJkqLckxrtFICHAMxiX0fWLfNtaoUPZ+6zpt+9zi/NBZ2yv+RkhcBoFdXLQxRfWsXTi78Ewk5Kij5B/878U8+B0vd8xqY+ASGgAAAABJRU5ErkJggg==',
			'B21D' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAbElEQVR4nGNYhQEaGAYTpIn7QgMYQximMIY6IIkFTGFtZQhhdAhAFmsVaXQEiomgqGNodJgCFwM7KTRq1dJV01ZmTUNyH1AdEKLpbWUIwBRjdMAQm8LaABJDdktogGioIxAiu3mgwo+KEIv7AO09zAJW9sdnAAAAAElFTkSuQmCC',
			'F371' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAYUlEQVR4nGNYhQEaGAYTpIn7QkNZQ1hDA1qRxQIaRID8gKmoYgyNDg0BoWhirUBRmF6wk0KjVoWtWgqESO4Dq5vC0IphXgCmmKMDuphIK2sDuhjQzQ0MoQGDIPyoCLG4DwABSM2EfOb+9wAAAABJRU5ErkJggg==',
			'505E' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAbUlEQVR4nGNYhQEaGAYTpIn7QkMYAlhDHUMDkMQCGhhDWBsYHRhQxFhb0cUCA0QaXafCxcBOCps2bWVqZmZoFrL7WkUaHRoCUfRiEwtoBdmBKiYyhTGE0dERRYw1gCGAIZQRxc0DFX5UhFjcBwA0m8msPWIOJgAAAABJRU5ErkJggg==',
			'CC8C' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAXklEQVR4nGNYhQEaGAYTpIn7WEMYQxlCGaYGIImJtLI2Ojo6BIggiQU0ijS4NgQ6sCCLNYg0MAIVIrsvatW0VatCV2Yhuw9NHVyMFWgeAwE7sLkFm5sHKvyoCLG4DwDW3cvtfqGzKQAAAABJRU5ErkJggg==',
			'2DC9' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAa0lEQVR4nGNYhQEaGAYTpIn7WANEQxhCHaY6IImJTBFpZXQICAhAEgtoFWl0bRB0EEHWDRZjhIlB3DRt2srUVauiwpDdFwBSxzAVWS9QF0isAVmMtQEkJoBih0gDpltCQzHdPFDhR0WIxX0AKk/MNV9b0lEAAAAASUVORK5CYII=',
			'A8AC' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAcElEQVR4nGNYhQEaGAYTpIn7GB0YQximMEwNQBJjDWBtZQhlCBBBEhOZItLo6OjowIIkFtDK2sraEOiA7L6opSvDlq6KzEJ2H5o6MAwNFWl0DUUVC2gFigHVYdoRgOKWgFbGEKAYipsHKvyoCLG4DwDuOcyEB2ICLwAAAABJRU5ErkJggg==',
			'81C9' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAZ0lEQVR4nGNYhQEaGAYTpIn7WAMYAhhCHaY6IImJTGEMYHQICAhAEgtoZQ1gbRB0EEFRxwAUY4SJgZ20NGpV1NJVq6LCkNwHUccwVQTFPLBYA6aYAIYd6G4BuiQU3c0DFX5UhFjcBwAdOcnKybM4XgAAAABJRU5ErkJggg==',
			'A1BE' => 'iVBORw0KGgoAAAANSUhEUgAAAEkAAAAhAgMAAADoum54AAAACVBMVEX///8AAADS0tIrj1xmAAAAW0lEQVR4nGNYhQEaGAYTpIn7GB0YAlhDGUMDkMRYAxgDWBsdHZDViUxhDWBtCEQRC2hlQFYHdlLUUiAKXRmaheQ+NHVgGBrKgN08/HZAxVhD0d08UOFHRYjFfQDS2sj/oYT6JAAAAABJRU5ErkJggg=='        
        );
        $this->text = array_rand( $images );
        return $images[ $this->text ] ;    
    }
    
    function out_processing_gif(){
        $image = dirname(__FILE__) . '/processing.gif';
        $base64_image = "R0lGODlhFAAUALMIAPh2AP+TMsZiALlcAKNOAOp4ANVqAP+PFv///wAAAAAAAAAAAAAAAAAAAAAAAAAAACH/C05FVFNDQVBFMi4wAwEAAAAh+QQFCgAIACwAAAAAFAAUAAAEUxDJSau9iBDMtebTMEjehgTBJYqkiaLWOlZvGs8WDO6UIPCHw8TnAwWDEuKPcxQml0Ynj2cwYACAS7VqwWItWyuiUJB4s2AxmWxGg9bl6YQtl0cAACH5BAUKAAgALAEAAQASABIAAAROEMkpx6A4W5upENUmEQT2feFIltMJYivbvhnZ3Z1h4FMQIDodz+cL7nDEn5CH8DGZhcLtcMBEoxkqlXKVIgAAibbK9YLBYvLtHH5K0J0IACH5BAUKAAgALAEAAQASABIAAAROEMkphaA4W5upMdUmDQP2feFIltMJYivbvhnZ3V1R4BNBIDodz+cL7nDEn5CH8DGZAMAtEMBEoxkqlXKVIg4HibbK9YLBYvLtHH5K0J0IACH5BAUKAAgALAEAAQASABIAAAROEMkpjaE4W5tpKdUmCQL2feFIltMJYivbvhnZ3R0A4NMwIDodz+cL7nDEn5CH8DGZh8ONQMBEoxkqlXKVIgIBibbK9YLBYvLtHH5K0J0IACH5BAUKAAgALAEAAQASABIAAAROEMkpS6E4W5spANUmGQb2feFIltMJYivbvhnZ3d1x4JMgIDodz+cL7nDEn5CH8DGZgcBtMMBEoxkqlXKVIggEibbK9YLBYvLtHH5K0J0IACH5BAUKAAgALAEAAQASABIAAAROEMkpAaA4W5vpOdUmFQX2feFIltMJYivbvhnZ3V0Q4JNhIDodz+cL7nDEn5CH8DGZBMJNIMBEoxkqlXKVIgYDibbK9YLBYvLtHH5K0J0IACH5BAUKAAgALAEAAQASABIAAAROEMkpz6E4W5tpCNUmAQD2feFIltMJYivbvhnZ3R1B4FNRIDodz+cL7nDEn5CH8DGZg8HNYMBEoxkqlXKVIgQCibbK9YLBYvLtHH5K0J0IACH5BAkKAAgALAEAAQASABIAAAROEMkpQ6A4W5spIdUmHQf2feFIltMJYivbvhnZ3d0w4BMAIDodz+cL7nDEn5CH8DGZAsGtUMBEoxkqlXKVIgwGibbK9YLBYvLtHH5K0J0IADs=";
        $binary = is_file($image) ? join("",file($image)) : base64_decode($base64_image); 
        header("Cache-Control: post-check=0, pre-check=0, max-age=0, no-store, no-cache, must-revalidate");
        header("Pragma: no-cache");
        header("Content-type: image/gif");
        echo $binary;
    }

}
# end of class phpfmgImage
# ------------------------------------------------------
# end of module : captcha


# module user
# ------------------------------------------------------
function phpfmg_user_isLogin(){
    return ( isset($_SESSION['authenticated']) && true === $_SESSION['authenticated'] );
}


function phpfmg_user_logout(){
    session_destroy();
    header("Location: admin.php");
}

function phpfmg_user_login()
{
    if( phpfmg_user_isLogin() ){
        return true ;
    };
    
    $sErr = "" ;
    if( 'Y' == $_POST['formmail_submit'] ){
        if(
            defined( 'PHPFMG_USER' ) && strtolower(PHPFMG_USER) == strtolower($_POST['Username']) &&
            defined( 'PHPFMG_PW' )   && strtolower(PHPFMG_PW) == strtolower($_POST['Password']) 
        ){
             $_SESSION['authenticated'] = true ;
             return true ;
             
        }else{
            $sErr = 'Login failed. Please try again.';
        }
    };
    
    // show login form 
    phpfmg_admin_header();
?>
<form name="frmFormMail" action="" method='post' enctype='multipart/form-data'>
<input type='hidden' name='formmail_submit' value='Y'>
<br><br><br>

<center>
<div style="width:380px;height:260px;">
<fieldset style="padding:18px;" >
<table cellspacing='3' cellpadding='3' border='0' >
	<tr>
		<td class="form_field" valign='top' align='right'>Email :</td>
		<td class="form_text">
            <input type="text" name="Username"  value="<?php echo $_POST['Username']; ?>" class='text_box' >
		</td>
	</tr>

	<tr>
		<td class="form_field" valign='top' align='right'>Password :</td>
		<td class="form_text">
            <input type="password" name="Password"  value="" class='text_box'>
		</td>
	</tr>

	<tr><td colspan=3 align='center'>
        <input type='submit' value='Login'><br><br>
        <?php if( $sErr ) echo "<span style='color:red;font-weight:bold;'>{$sErr}</span><br><br>\n"; ?>
        <a href="admin.php?mod=mail&func=request_password">I forgot my password</a>   
    </td></tr>
</table>
</fieldset>
</div>
<script type="text/javascript">
    document.frmFormMail.Username.focus();
</script>
</form>
<?php
    phpfmg_admin_footer();
}


function phpfmg_mail_request_password(){
    $sErr = '';
    if( $_POST['formmail_submit'] == 'Y' ){
        if( strtoupper(trim($_POST['Username'])) == strtoupper(trim(PHPFMG_USER)) ){
            phpfmg_mail_password();
            exit;
        }else{
            $sErr = "Failed to verify your email.";
        };
    };
    
    $n1 = strpos(PHPFMG_USER,'@');
    $n2 = strrpos(PHPFMG_USER,'.');
    $email = substr(PHPFMG_USER,0,1) . str_repeat('*',$n1-1) . 
            '@' . substr(PHPFMG_USER,$n1+1,1) . str_repeat('*',$n2-$n1-2) . 
            '.' . substr(PHPFMG_USER,$n2+1,1) . str_repeat('*',strlen(PHPFMG_USER)-$n2-2) ;


    phpfmg_admin_header("Request Password of Email Form Admin Panel");
?>
<form name="frmRequestPassword" action="admin.php?mod=mail&func=request_password" method='post' enctype='multipart/form-data'>
<input type='hidden' name='formmail_submit' value='Y'>
<br><br><br>

<center>
<div style="width:580px;height:260px;text-align:left;">
<fieldset style="padding:18px;" >
<legend>Request Password</legend>
Enter Email Address <b><?php echo strtoupper($email) ;?></b>:<br />
<input type="text" name="Username"  value="<?php echo $_POST['Username']; ?>" style="width:380px;">
<input type='submit' value='Verify'><br>
The password will be sent to this email address. 
<?php if( $sErr ) echo "<br /><br /><span style='color:red;font-weight:bold;'>{$sErr}</span><br><br>\n"; ?>
</fieldset>
</div>
<script type="text/javascript">
    document.frmRequestPassword.Username.focus();
</script>
</form>
<?php
    phpfmg_admin_footer();    
}


function phpfmg_mail_password(){
    phpfmg_admin_header();
    if( defined( 'PHPFMG_USER' ) && defined( 'PHPFMG_PW' ) ){
        $body = "Here is the password for your form admin panel:\n\nUsername: " . PHPFMG_USER . "\nPassword: " . PHPFMG_PW . "\n\n" ;
        if( 'html' == PHPFMG_MAIL_TYPE )
            $body = nl2br($body);
        mailAttachments( PHPFMG_USER, "Password for Your Form Admin Panel", $body, PHPFMG_USER, 'You', "You <" . PHPFMG_USER . ">" );
        echo "<center>Your password has been sent.<br><br><a href='admin.php'>Click here to login again</a></center>";
    };   
    phpfmg_admin_footer();
}


function phpfmg_writable_check(){
 
    if( is_writable( dirname(PHPFMG_SAVE_FILE) ) && is_writable( dirname(PHPFMG_EMAILS_LOGFILE) )  ){
        return ;
    };
?>
<style type="text/css">
    .fmg_warning{
        background-color: #F4F6E5;
        border: 1px dashed #ff0000;
        padding: 16px;
        color : black;
        margin: 10px;
        line-height: 180%;
        width:80%;
    }
    
    .fmg_warning_title{
        font-weight: bold;
    }

</style>
<br><br>
<div class="fmg_warning">
    <div class="fmg_warning_title">Your form data or email traffic log is NOT saving.</div>
    The form data (<?php echo PHPFMG_SAVE_FILE ?>) and email traffic log (<?php echo PHPFMG_EMAILS_LOGFILE?>) will be created automatically when the form is submitted. 
    However, the script doesn't have writable permission to create those files. In order to save your valuable information, please set the directory to writable.
     If you don't know how to do it, please ask for help from your web Administrator or Technical Support of your hosting company.   
</div>
<br><br>
<?php
}


function phpfmg_log_view(){
    $n = isset($_REQUEST['file'])  ? $_REQUEST['file']  : '';
    $files = array(
        1 => PHPFMG_EMAILS_LOGFILE,
        2 => PHPFMG_SAVE_FILE,
    );
    
    phpfmg_admin_header();
   
    $file = $files[$n];
    if( is_file($file) ){
        if( 1== $n ){
            echo "<pre>\n";
            echo join("",file($file) );
            echo "</pre>\n";
        }else{
            $man = new phpfmgDataManager();
            $man->displayRecords();
        };
     

    }else{
        echo "<b>No form data found.</b>";
    };
    phpfmg_admin_footer();
}


function phpfmg_log_download(){
    $n = isset($_REQUEST['file'])  ? $_REQUEST['file']  : '';
    $files = array(
        1 => PHPFMG_EMAILS_LOGFILE,
        2 => PHPFMG_SAVE_FILE,
    );

    $file = $files[$n];
    if( is_file($file) ){
        phpfmg_util_download( $file, PHPFMG_SAVE_FILE == $file ? 'form-data.csv' : 'email-traffics.txt', true, 1 ); // skip the first line
    }else{
        phpfmg_admin_header();
        echo "<b>No email traffic log found.</b>";
        phpfmg_admin_footer();
    };

}


function phpfmg_log_delete(){
    $n = isset($_REQUEST['file'])  ? $_REQUEST['file']  : '';
    $files = array(
        1 => PHPFMG_EMAILS_LOGFILE,
        2 => PHPFMG_SAVE_FILE,
    );
    phpfmg_admin_header();

    $file = $files[$n];
    if( is_file($file) ){
        echo unlink($file) ? "It has been deleted!" : "Failed to delete!" ;
    };
    phpfmg_admin_footer();
}


function phpfmg_util_download($file, $filename='', $toCSV = false, $skipN = 0 ){
    if (!is_file($file)) return false ;

    set_time_limit(0);


    $buffer = "";
    $i = 0 ;
    $fp = @fopen($file, 'rb');
    while( !feof($fp)) { 
        $i ++ ;
        $line = fgets($fp);
        if($i > $skipN){ // skip lines
            if( $toCSV ){ 
              $line = str_replace( chr(0x09), ',', $line );
              $buffer .= phpfmg_data2record( $line, false );
            }else{
                $buffer .= $line;
            };
        }; 
    }; 
    fclose ($fp);
  

    
    /*
        If the Content-Length is NOT THE SAME SIZE as the real conent output, Windows+IIS might be hung!!
    */
    $len = strlen($buffer);
    $filename = basename( '' == $filename ? $file : $filename );
    $file_extension = strtolower(substr(strrchr($filename,"."),1));

    switch( $file_extension ) {
        case "pdf": $ctype="application/pdf"; break;
        case "exe": $ctype="application/octet-stream"; break;
        case "zip": $ctype="application/zip"; break;
        case "doc": $ctype="application/msword"; break;
        case "xls": $ctype="application/vnd.ms-excel"; break;
        case "ppt": $ctype="application/vnd.ms-powerpoint"; break;
        case "gif": $ctype="image/gif"; break;
        case "png": $ctype="image/png"; break;
        case "jpeg":
        case "jpg": $ctype="image/jpg"; break;
        case "mp3": $ctype="audio/mpeg"; break;
        case "wav": $ctype="audio/x-wav"; break;
        case "mpeg":
        case "mpg":
        case "mpe": $ctype="video/mpeg"; break;
        case "mov": $ctype="video/quicktime"; break;
        case "avi": $ctype="video/x-msvideo"; break;
        //The following are for extensions that shouldn't be downloaded (sensitive stuff, like php files)
        case "php":
        case "htm":
        case "html": 
                $ctype="text/plain"; break;
        default: 
            $ctype="application/x-download";
    }
                                            

    //Begin writing headers
    header("Pragma: public");
    header("Expires: 0");
    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
    header("Cache-Control: public"); 
    header("Content-Description: File Transfer");
    //Use the switch-generated Content-Type
    header("Content-Type: $ctype");
    //Force the download
    header("Content-Disposition: attachment; filename=".$filename.";" );
    header("Content-Transfer-Encoding: binary");
    header("Content-Length: ".$len);
    
    while (@ob_end_clean()); // no output buffering !
    flush();
    echo $buffer ;
    
    return true;
 
    
}
?>