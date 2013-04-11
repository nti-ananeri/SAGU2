<?php
define('FPDF_FONTPATH', $MIOLO->getModulePath('basic', '/classes/fpdf/font/'));

$MIOLO = MIOLO::getInstance();
$MIOLO->Uses('classes/fpdf/fpdf16.php', 'basic');
class PDF extends FPDF
{
    public $title;
    public $infos;
    public $fontSizeBody;
    public $psize;
    public $lsize;
    public $module = 'basic';
    public $useUserInfo = true;
   
    public function AddPage($orientation='P', $size='mm', $format='A4')
    {
        FPDF::AddPage($orientation, $format);
    }

    public function loadInfos($unitId = null)
    {
     	$MIOLO  = MIOLO::getInstance();
        $this->module = MIOLO::getCurrentModule();
		$bCompany = $MIOLO->getBusiness('basic','BusCompany');
		$bPerson = $MIOLO->getBusiness('basic','BusPhysicalPerson');
		$bLPerson = $MIOLO->getBusiness('basic','BusLegalPerson');
        $bCountry = $MIOLO->getBusiness('basic', 'BusCountry');
        $bUnit    = $MIOLO->getBusiness('basic', 'BusUnit');

        if ( strlen($unitId) > 0 )
        {
    		$unit   = $bUnit->getUnit($unitId);
            $dataC   = $bCompany->getCompany($unit->companyId);

            if ( strlen($dataC->companyId) == 0 )
            {
                $dataC   = $bCompany->getCompany(DEFAULT_COMPANY_CONF);
            }
        }
        else 
        {
    		$dataC   = $bCompany->getCompany(DEFAULT_COMPANY_CONF);
        }
        
        $dataLP	 = $bLPerson->getLegalPerson($dataC->personId);
        $country = $bCountry->getCountryByCityId($dataLP->cityId);

        $this->pdfInfo->legalPerson = $dataLP;
        $this->pdfInfo->company     = $dataC;
        $this->pdfInfo->legalPerson->country = $country;
        $this->company = $dataC;
        $this->pdfInfo->userName = trim($MIOLO->login->id);
    }

    public function Header()
    {
        $this->psize =   ROUND((($this->wPt/$this->k)-($this->lMargin*2)),2);
     	$MIOLO  = MIOLO::getInstance();
        $this->module = MIOLO::getCurrentModule();
        //Imagem do cabeÃ§alho
        $FONT_SIZE_CB = 8;
        $this->fontSizeBody = 8;
        $FONT_SIZE_TITLE = 11;
        $this->lsize = 4;
        $this->setFont(DEFAULT_REPORT_FONT, 'I', $this->fontSizeBody);
        $this->setTextColor(0,0,0);
        $y = 0;
        
        if($this->useUserInfo)
        {
            $this->cell($this->psize, $this->lsize, _M('Username', 'admin').': '.$this->pdfInfo->userName, '', null, 'R', 0);
            $this->ln();
            $this->cell($this->psize, $this->lsize, _M('Date', 'basic').': '.date(MASK_DATE_PHP.' H:i:s'), '', null, 'R', 0);
            $this->ln();
            $y=($this->lsize*2);
        }
        $this->cell($this->psize, $this->lsize, $title, 'LRT', null, null, 0);
        $this->ln();
        //Titulo do relatorio  
        $this->setFont(DEFAULT_REPORT_FONT, 'B', $FONT_SIZE_CB);
        $this->cell($this->psize, $this->lsize, $this->pdfInfo->legalPerson->name .' - '. $this->pdfInfo->legalPerson->shortName, 'LR', null, 'C');
        $this->ln();
        $this->cell($this->psize, $this->lsize, $this->pdfInfo->company->name .' - '.$this->pdfInfo->legalPerson->acronym, 'LR', null, 'C');
        $this->ln();
        $this->setFont(DEFAULT_REPORT_FONT, 'B', $FONT_SIZE_CB-1);
        $this->cell($this->psize, $this->lsize, strtoupper($this->pdfInfo->legalPerson->location . ', ' . $this->pdfInfo->legalPerson->number . ' - ' . $this->pdfInfo->legalPerson->neighborhood . ' - ' . _M('Zip code', 'basic') .':'  . $this->pdfInfo->legalPerson->zipCode . ' /  ' . $this->pdfInfo->legalPerson->cityName . '-' . $this->pdfInfo->legalPerson->stateId ), 'LR', null, 'C');
        $this->pdfInfo->zipCode = $this->pdfInfo->legalPerson->zipCode;
        $this->pdfInfo->cityName = $this->pdfInfo->legalPerson->cityName;
        $this->pdfInfo->stateId = $this->pdfInfo->legalPerson->stateId;
        $this->pdfInfo->legalPersonName = $this->pdfInfo->legalPerson->name;
        $this->pdfInfo->legalPersonAddress = strtoupper( $this->pdfInfo->legalPerson->location . ', '._M('Number', 'basic') . ' ' . $this->pdfInfo->legalPerson->number . ' - ' . $this->pdfInfo->legalPerson->neighborhood . ' - ' . $this->pdfInfo->legalPerson->cityName . '/' . $this->pdfInfo->legalPerson->stateId );
        $this->ln();
        $this->setFont(DEFAULT_REPORT_FONT, 'B', $FONT_SIZE_CB);
        $this->cell($this->psize, $this->lsize, strtoupper(_M('Phone', 'basic'). ' / ' . _M('Fax', 'basic').': '.$this->pdfInfo->legalPerson->phone .  ' / ' . $this->pdfInfo->legalPerson->fax), 'LR', null, 'C');
        $this->ln();
        $x=$this->lsize*2;
        if(strlen($this->title) > 0 )
        {
            $this->cell($this->psize, $this->lsize, null, 'LR', null, null, 0);
            $this->ln();
            $this->setFont(DEFAULT_REPORT_FONT, 'B', $FONT_SIZE_TITLE);
            $this->cell($this->psize, $LINE_SIZE, $this->title, 'LR', null, 'C');
            $this->ln();
            $x=0;
            if(SAGUFile::getPhotoPath($this->pdfInfo->company->personId))
            {
                $this->Image(SAGUFile::getPhotoPath($this->pdfInfo->company->personId), $this->lMargin+2.5, $this->tMargin+2.5+$y, NULL, (round(116/$this->k,0)/1.8), PHOTO_FORMAT);
            }
        }
        else
        {
            if(SAGUFile::getPhotoPath($this->pdfInfo->company->personId))
            {
                $this->Image(SAGUFile::getPhotoPath($this->pdfInfo->company->personId), $this->lMargin+2.5, $this->tMargin+2.5+$y, NULL, (round(97/$this->k,0)/1.8), PHOTO_FORMAT);
            }
        }
        $this->cell($this->psize, $this->lsize, null, 'LRB', null, null, 0);
        $this->ln();
        $this->ln();
    }
    public function generatePDF()
    {
        $this->outPut();
    }
    
    public function __construct($filters = null)
    {
        //MIOLO::vd($filters); die();
        FPDF::__construct();
        $this->title = !$this->title ? strtoupper(_M('Test report', 'basic')) : $this->title;
        if ( count($filters) > 0 )
        {
            foreach($filters as $item => $value)
            {
                $this->filters->{$item} = $value;
            }
        }
        $this->loadInfos($this->filters->unitId);
    }

    public function Footer()
    {
        $this->setY(-15);
        $pn = $this->PageNo();
        if($this->AutoPageBreak)
        {
            $pn .='/{nb}';
        }
        $this->cell($this->psize, $this->lsize, '', 'B', 1);
        $this->ln(); 
		$this->setFont(DEFAULT_REPORT_FONT, 'BI', 8);
		$this->cell($this->psize/2, $this->lsize, $this->title, 0, 0, 'L');
   		$this->setFont(DEFAULT_REPORT_FONT, 'I', 8);
		$this->cell($this->psize/2, $this->lsize, _M('Page @1', 'basic', $pn), 0, 0, 'R');
        $this->ln();
    }

    protected function replaceText($obj)
    {
    	//FINANCE
	    $obj->finance->courseTotalValue = $obj->finance->courseValue+$obj->finance->courseValue2+$obj->finance->enrollValue;
        //COURSE PRICE
        $procurar[] = '$FINANCE_POLICY_ID_FOR_REENROLL';
        $substituir[] = $obj->finance->policyIdForReEnroll;
        
        $procurar[] = '$FINANCE_POLICY_ID_FOR_ENROLL';
        $substituir[] = $obj->finance->policyIdForEnroll;

        $procurar[] = '$FINANCE_POLICY_ID';
        $substituir[] = $obj->finance->policyId;

        $procurar[] = '$FINANCE_PARCEL2_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive(SAGU::formatNumber($obj->finance->parcelValue2, false), 'M', true));

        $procurar[] = '$FINANCE_PARCEL_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive(SAGU::formatNumber($obj->finance->parcelValue, false), 'M', true));

        $procurar[] = '$FINANCE_PARCEL2_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->parcelValue2, true);

        $procurar[] = '$FINANCE_PARCEL_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->parcelValue, true);        
        
        $procurar[] = '$FINANCE_COURSE_VALUE2_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->courseValue2, 'M', true));

        $procurar[] = '$FINANCE_COURSE_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->courseValue, 'M', true));

        $procurar[] = '$FINANCE_COURSE_TOTAL_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->courseTotalValue, 'M', true));

        $procurar[] = '$FINANCE_COURSE_VALUE2';
        $substituir[] = SAGU::formatNumber($obj->finance->courseValue2, true);

        $procurar[] = '$FINANCE_COURSE_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->courseValue, true);

        $procurar[] = '$FINANCE_COURSE_TOTAL_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->courseTotalValue, true);

        $procurar[] = '$FINANCE_ENROLL_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->enrollValue, 'M', true));

        $procurar[] = '$FINANCE_ENROLL_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->enrollValue, true);

        $procurar[] = '$FINANCE_CURRICULAR_COMPONENT_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->curricularComponentPrice, 'M', true));

        $procurar[] = '$FINANCE_CURRICULAR_COMPONENT_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->curricularComponentPrice, true);

        //INCENTIVES
        //$procurar[] = '$FINANCE_INCENTIVE_VALUE_IS_PERCENT'; 

        /*procurar[] = '$FINANCE_INCENTIVE_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->incentiveValue, 'M', true));

        $procurar[] = '$FINANCE_INCENTIVE_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->incentiveValue, true);*/

        $procurar[] = '$FINANCE_INCENTIVE_IN_PERCENT_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->incentiveInPercent, 'M'));

        $procurar[] = '$FINANCE_INCENTIVE_IN_PERCENT';
        $substituir[] = SAGU::formatNumber($obj->finance->incentiveInPercent, true);

        $procurar[] = '$FINANCE_INCENTIVE_IN_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->incentiveInValue, 'M', true));

        $procurar[] = '$FINANCE_INCENTIVE_IN_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->incentiveInValue, true);

        $procurar[] = '$FINANCE_INCENTIVE_START_DATE';
        $substituir[] = $obj->finance->startDate;

        $procurar[] = '$FINANCE_INCENTIVE_END_DATE';
        $substituir[] = $obj->finance->endDate;

        $procurar[] = '$FINANCE_INCENTIVE_DESCRIPTION';
        $substituir[] = $obj->finance->incentiveDescription;


        //POLICY
        $procurar[] = '$FINANCE_MONTH_POLICY_DESCRIPTION'; 
        $substituir[] = $obj->finance->monthPolicy->description;

//        $procurar[] = '$FINANCE_MONTH_POLICY_IS_DISCOUNT_IN_PERCENT';
//        $procurar[] = '$FINANCE_MONTH_POLICY_IS_FINE_IN_PERCENT';
//        $procurar[] = '$FINANCE_MONTH_POLICY_IS_INTEREST_IN_PERCENT';
//        $procurar[] = '$FINANCE_MONTH_POLICY_IS_DISCOUNT_AT_LAST_MONTH_DAY';
//        $procurar[] = '$FINANCE_MONTH_POLICY_IS_FINE_IN_ORIGINAL_VALUE';

        $procurar[] = '$FINANCE_MONTH_POLICY_DISCOUNT_IN_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->monthPolicy->discountInValue, 'M', true));

        $procurar[] = '$FINANCE_MONTH_POLICY_DISCOUNT_IN_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->monthPolicy->discountInValue, true);

        $procurar[] = '$FINANCE_MONTH_POLICY_DISCOUNT_IN_PERCENT_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->monthPolicy->discountInPercent, 'M'));

        $procurar[] = '$FINANCE_MONTH_POLICY_DISCOUNT_IN_PERCENT';
        $substituir[] = SAGU::formatNumber($obj->finance->monthPolicy->discountInPercent, true);

        $procurar[] = '$FINANCE_MONTH_POLICY_FINE_IN_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->monthPolicy->fineInValue, 'M', true));
        
        $procurar[] = '$FINANCE_MONTH_POLICY_FINE_IN_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->monthPolicy->fineInValue, true);

        $procurar[] = '$FINANCE_MONTH_POLICY_FINE_IN_PERCENT';
        $substituir[] = SAGU::formatNumber($obj->finance->monthPolicy->fineInPercent, true);

        $procurar[] = '$FINANCE_MONTH_POLICY_INTEREST_IN_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->monthPolicy->interestInValue, 'M', true));
        
        $procurar[] = '$FINANCE_MONTH_POLICY_INTEREST_IN_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->monthPolicy->interestInValue, true);

        $procurar[] = '$FINANCE_MONTH_POLICY_INTEREST_IN_PERCENT';
        $substituir[] = SAGU::formatNumber($obj->finance->monthPolicy->interestInPercent, true);

        //POLICY FOR ENROLL
        $procurar[] = '$FINANCE_ENROLL_POLICY_DESCRIPTION'; 
        $substituir[] = $obj->finance->enrollPolicy->description;
        /*$procurar[] = '$FINANCE_ENROLL_POLICY_IS_DISCOUNT_IN_PERCENT';
        $procurar[] = '$FINANCE_ENROLL_POLICY_IS_FINE_IN_PERCENT';
        $procurar[] = '$FINANCE_ENROLL_POLICY_IS_INTEREST_IN_PERCENT';
        $procurar[] = '$FINANCE_ENROLL_POLICY_IS_DISCOUNT_AT_LAST_MONTH_DAY';
        $procurar[] = '$FINANCE_ENROLL_POLICY_IS_FINE_IN_ORIGINAL_VALUE';*/

        $procurar[] = '$FINANCE_ENROLL_POLICY_DISCOUNT_IN_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->enrollPolicy->discountInValue));

        $procurar[] = '$FINANCE_ENROLL_POLICY_DISCOUNT_IN_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->enrollPolicy->discountInValue, true);

        $procurar[] = '$FINANCE_ENROLL_POLICY_DISCOUNT_IN_PERCENT';
        $substituir[] = SAGU::formatNumber($obj->finance->enrollPolicy->discountInPercent, true);
//        $procurar[] = '$FINANCE_ENROLL_POLICY_DISCOUNT';

        $procurar[] = '$FINANCE_ENROLL_POLICY_FINE_IN_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->enrollPolicy->fineInValue, 'M', true));

        $procurar[] = '$FINANCE_ENROLL_POLICY_FINE_IN_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->enrollPolicy->fineInValue, true);

        $procurar[] = '$FINANCE_ENROLL_POLICY_FINE_IN_PERCENT';
        $substituir[] = SAGU::formatNumber($obj->finance->enrollPolicy->fineInPercent, true);

//        $procurar[] = '$FINANCE_ENROLL_POLICY_FINE'; 
        
        $procurar[] = '$FINANCE_ENROLL_POLICY_INTEREST_IN_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->enrollPolicy->interestInValue, 'M', true));

        $procurar[] = '$FINANCE_ENROLL_POLICY_INTEREST_IN_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->enrollPolicy->interestInValue, true);

        $procurar[] = '$FINANCE_ENROLL_POLICY_INTEREST_IN_PERCENT';
        $substituir[] = SAGU::formatNumber($obj->finance->enrollPolicy->interestInPercent, true);

//        $procurar[] = '$FINANCE_ENROLL_POLICY_INTEREST';

        //POLICY FOR REENROLL
        $procurar[] = '$FINANCE_REENROLL_POLICY_DESCRIPTION'; 
        $substituir[] = $obj->finance->reEnrollPolicy->description;

/*        $procurar[] = '$FINANCE_REENROLL_POLICY_IS_DISCOUNT_IN_PERCENT';
        $substituir[] = $obj->finance->reEnrollPolicy->
        $procurar[] = '$FINANCE_REENROLL_POLICY_IS_FINE_IN_PERCENT';
        $procurar[] = '$FINANCE_REENROLL_POLICY_IS_INTEREST_IN_PERCENT';
        $procurar[] = '$FINANCE_REENROLL_POLICY_IS_DISCOUNT_AT_LAST_MONTH_DAY';
        $procurar[] = '$FINANCE_REENROLL_POLICY_IS_FINE_IN_ORIGINAL_VALUE';*/

        $procurar[] = '$FINANCE_REENROLL_POLICY_DISCOUNT_IN_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->reEnrollPolicy->discountInValue, 'M', true));

        $procurar[] = '$FINANCE_REENROLL_POLICY_DISCOUNT_IN_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->reEnrollPolicy->discountInValue, true);

        $procurar[] = '$FINANCE_REENROLL_POLICY_DISCOUNT_IN_PERCENT';
        $substituir[] = SAGU::formatNumber($obj->finance->reEnrollPolicy->discountInPercent, true);

//        $procurar[] = '$FINANCE_REENROLL_POLICY_DISCOUNT';

        $procurar[] = '$FINANCE_REENROLL_POLICY_FINE_IN_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->reEnrollPolicy->fineInValue, 'M', true));

        $procurar[] = '$FINANCE_REENROLL_POLICY_FINE_IN_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->reEnrollPolicy->fineInValue, true);

        $procurar[] = '$FINANCE_REENROLL_POLICY_FINE_IN_PERCENT';
        $substituir[] = SAGU::formatNumber($obj->finance->reEnrollPolicy->fineInPercent, true);

//        $procurar[] = '$FINANCE_REENROLL_POLICY_FINE'; 
        
        $procurar[] = '$FINANCE_REENROLL_POLICY_INTEREST_IN_VALUE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->finance->reEnrollPolicy->interestInValue));

        $procurar[] = '$FINANCE_REENROLL_POLICY_INTEREST_IN_VALUE';
        $substituir[] = SAGU::formatNumber($obj->finance->reEnrollPolicy->interestInValue, 'M', true);

        $procurar[] = '$FINANCE_REENROLL_POLICY_INTEREST_IN_PERCENT';
        $substituir[] = SAGU::formatNumber($obj->finance->reEnrollPolicy->interestInPercent, true);

//        $procurar[] = '$FINANCE_REENROLL_POLICY_INTEREST';

        //ACADEMIC

        //CONTRACT
        $procurar[] = '$ACADEMIC_CONTRACT_CONTRACT_ID';
        $substituir[] = $obj->academic->contract->contractId;

        $procurar[] = '$ACADEMIC_CONTRACT_COURSE_ID';
        $substituir[] = $obj->academic->contract->courseId;
        
        $procurar[] = '$ACADEMIC_CONTRACT_COURSE_VERSION';
        $substituir[] = $obj->academic->contract->courseVersion;

        $procurar[] = '$ACADEMIC_CONTRACT_TURN_ID';
        $substituir[] = $obj->academic->contract->turnId;

        $procurar[] = '$ACADEMIC_CONTRACT_UNIT_ID';
        $substituir[] = $obj->academic->contract->unitId;

        $procurar[] = '$ACADEMIC_CONTRACT_FORMATION_DATE';
        $substituir[] = $obj->academic->contract->formationDate;

        $procurar[] = '$CONTRACT_FORMATION_DATE';
        $substituir[] = $obj->academic->contract->formationDate;

        $procurar[] = '$ACADEMIC_CONTRACT_FORMATION_PERIOD_ID';
        $substituir[] = $obj->academic->contract->formationPeriodId;

        $procurar[] = '$ACADEMIC_CONTRACT_CONCLUSION_DATE';
        $substituir[] = $obj->academic->contract->conclusionDate;

        $procurar[] = '$ACADEMIC_CONTRACT_EMENDS_DATE';
        $substituir[] = $obj->academic->contract->emendsDate;

        $procurar[] = '$ACADEMIC_CONTRACT_DIPLOMA_DATE';
        $substituir[] = $obj->academic->contract->diplomaDate;

        $procurar[] = '$ACADEMIC_CONTRACT_INSCRIPTION_SELECTIVE_PROC_ID';
        $substituir[] = $obj->academic->contract->inscriptionSelectiveProcId;

        $procurar[] = '$ACADEMIC_CONTRACT_MATURITY_DAY_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->contract->maturityDay, 'M'));

        $procurar[] = '$ACADEMIC_CONTRACT_MATURITY_DAY';
        $substituir[] = $obj->academic->contract->maturityDay;

        $procurar[] = '$ACADEMIC_CONTRACT_IS_LISTENER';
        $substituir[] = $obj->academic->contract->isListener;

        $procurar[] = '$ACADEMIC_CONTRACT_IS_REQUEST_ACADEMIC_DEGREE';
        $substituir[] = $obj->academic->contract->isRequestAcademicDegree;

        $procurar[] = '$ACADEMIC_CONTRACT_OBS';
        $substituir[] = $obj->academic->contract->obs;
   
        $procurar[] = '$ACADEMIC_CONTRACT_PARCELS2_NUMBER_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->contract->parcelsNumber2, 'F'));

        $procurar[] = '$ACADEMIC_CONTRACT_PARCELS_NUMBER_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->contract->parcelsNumber, 'F'));

        $procurar[] = '$ACADEMIC_CONTRACT_PARCELS2_NUMBER';
        $substituir[] = $obj->academic->contract->parcelsNumber2;
        
        $procurar[] = '$ACADEMIC_CONTRACT_PARCELS_NUMBER';
        $substituir[] = $obj->academic->contract->parcelsNumber;
        
        $procurar[] = '$ACADEMIC_CONTRACT_POLICY_ID_FOR_ENROLL';
        $substituir[] = $obj->academic->contract->policyIdForEnroll;

        $procurar[] = '$ACADEMIC_CONTRACT_POLICY_ID_FOR_REENROLL';
        $substituir[] = $obj->academic->contract->policyIdForReEnroll;

        $procurar[] = '$ACADEMIC_CONTRACT_POLICY_ID';
        $substituir[] = $obj->academic->contract->policyId;

        $procurar[] = '$ACADEMIC_CONTRACT_COMMENTS';
        $substituir[] = $obj->academic->contract->comments;

        $procurar[] = '$ACADEMIC_CONTRACT_MONOGRAPH';
        $substituir[] = $obj->academic->contract->monograph;

        $procurar[] = '$ACADEMIC_CONTRACT_SERIE';
        $substituir[] = $obj->academic->contract->serie;

        $procurar[] = '$CONTRACT_SERIE';
        $substituir[] = $obj->academic->contract->serie;
        
        $procurar[] = '$ACADEMIC_CONTRACT_MONTHS2_NUMBER_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->contract->parcelsNumber2, 'F'));

        $procurar[] = '$ACADEMIC_CONTRACT_MONTHS_NUMBER_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->contract->parcelsNumber, 'F'));

        $procurar[] = '$ACADEMIC_CONTRACT_MONTHS2_NUMBER';
        $substituir[] = $obj->academic->contract->parcelsNumber2;
        
        $procurar[] = '$ACADEMIC_CONTRACT_MONTHS_NUMBER';
        $substituir[] = $obj->academic->contract->parcelsNumber;
        
        $procurar[] = '$ACADEMIC_CONTRACT_MONTHS_DURATION_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->contract->parcelsNumber + $obj->academic->contract->parcelsNumber2, 'M'));
        
        $procurar[] = '$ACADEMIC_CONTRACT_MONTHS_DURATION';
        $substituir[] = $obj->academic->contract->parcelsNumber + $obj->academic->contract->parcelsNumber2;

        //COURSE
        $procurar[] = '$ACADEMIC_COURSE_NAME';
        $substituir[] = ucwords(strtolower($obj->academic->course->name));

        $procurar[] = '$COURSENAME';
        $substituir[] = ucwords(strtolower($obj->academic->course->name));

        $procurar[] = '$ACADEMIC_COURSE_SHORTNAME';
        $substituir[] = $obj->academic->course->shortName;
        
        $procurar[] = '$ACADEMIC_COURSE_ACRONYM';
        $substituir[] = $obj->academic->course->acronym;
        
        $procurar[] = '$ACADEMIC_COURSE_BEGIN_DATE';
        $substituir[] = $obj->academic->course->courseBeginDate;

        $procurar[] = '$ACADEMIC_COURSE_END_DATE';
        $substituir[] = $obj->academic->course->courseEndDate;

        $procurar[] = '$ACADEMIC_COURSE_VERSION_BEGIN_DATE';
        $substituir[] = $obj->academic->course->courseVersionBeginDate;
        
        $procurar[] = '$ACADEMIC_COURSE_VERSION_END_DATE';
        $substituir[] = $obj->academic->course->courseVersionEndDate;

        $procurar[] = '$ACADEMIC_COURSE_RECOGNITION_DATE';
        $substituir[] = $obj->academic->course->recognitionDate;

        $procurar[] = '$ACADEMIC_COURSE_RECOGNITION_DOCUMENT_NUMBER'; //Resoluções
        $substituir[] = $obj->academic->course->recognitionDocumentNumber;

        $procurar[] = '$ACADEMIC_COURSE_MORE_INFO';
        $substituir[] = $obj->academic->course->courseMoreInfo;

        $procurar[] = '$ACADEMIC_COURSE_REQUIREMENTS';
        $substituir[] = $obj->academic->course->requirements;

        $procurar[] = '$ACADEMIC_COURSE_OBS';
        $substituir[] = $obj->academic->course->obs;

        $procurar[] = '$ACADEMIC_COURSE_INEP';
        $substituir[] = $obj->academic->course->inep;

        $procurar[] = '$ACADEMIC_COURSE_SEMESTER_TOTAL_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->course->semesterTotal, 'M'));

        $procurar[] = '$ACADEMIC_COURSE_SEMESTER_TOTAL';
        $substituir[] = $obj->academic->course->semesterTotal;

        $procurar[] = '$ACADEMIC_COURSE_CREDITS_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->course->credits, 'M'));

        $procurar[] = '$ACADEMIC_COURSE_CREDITS';
        $substituir[] = $obj->academic->course->credits;

        $procurar[] = '$ACADEMIC_COURSE_HOUR_TOTAL_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->course->hourTotal, 'F'));
        
        $procurar[] = '$ACADEMIC_COURSE_HOUR_TOTAL';
        $substituir[] = $obj->academic->course->hourTotal;

        $procurar[] = '$ACADEMIC_COURSE_HOUR_REQUIRED_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->course->hourRequired, 'M'));

        $procurar[] = '$ACADEMIC_COURSE_HOUR_REQUIRED';
        $substituir[] = $obj->academic->course->hourRequired;

        $procurar[] = '$ACADEMIC_COURSE_AUTHORIZATION_DATE';
        $substituir[] = $obj->academic->course->authorizationDate;

        $procurar[] = '$ACADEMIC_COURSE_AUTHORIZATION_DOCUMENT';
        $substituir[] = $obj->academic->course->authorizationDocument;

        $procurar[] = '$COURSE_AUTHORIZATION_DOCUMENT';
        $substituir[] = $obj->academic->course->authorizationDocument;

        $procurar[] = '$ACADEMIC_COURSE_MAXIMUM_DEPENDENT_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->academic->course->maximumDependent, 'F'));

        $procurar[] = '$ACADEMIC_COURSE_MAXIMUM_DEPENDENT';
        $substituir[] = $obj->academic->course->maximumDependent;

        $procurar[] = '$ACADEMIC_COURSE_TURN_DESCRIPTION';
        $substituir[] =  ucwords(strtolower($obj->academic->course->turnDescription));

        $procurar[] = '$ACADEMIC_COURSE_UNIT_DESCRIPTION';
        $substituir[] =  $obj->academic->course->unitDescription;

        //BASIC

        //PERSON
        $procurar[] = '$BASIC_PERSON_PERSON_ID';
        $substituir[] = $obj->basic->person->personId;

        $procurar[] = '$CONTRACT_PERSONID';
        $substituir[] = $obj->basic->person->personId;
    
        $procurar[] = '$PERSONID';
        $substituir[] = $obj->basic->person->personId;
    

        $procurar[] = '$BASIC_PERSON_PERSON_TITLE';
        $substituir[] = $obj->basic->person->personTitle;

        $procurar[] = '$BASIC_PERSON_NAME';
        $substituir[] = ucwords(strtolower($obj->basic->person->name));

        $procurar[] = '$CONTRACT_PERSONNAME';
        $substituir[] = ucwords(strtolower($obj->basic->person->name));

        $procurar[] = '$BASIC_PERSON_SEX';
        $substituir[] = $obj->basic->person->sex;

        $procurar[] = '$BASIC_PERSON_NICKNAME';
        $substituir[] = $obj->basic->person->nickName;

        $procurar[] = '$BASIC_PERSON_LOCATION';
        $substituir[] =  ucwords(strtolower($obj->basic->person->location));

        $procurar[] = '$BASIC_PERSON_NUMBER';
        $substituir[] = $obj->basic->person->number;

        $procurar[] = '$BASIC_PERSON_NEIGHBORHOOD';
        $substituir[] = ucwords(strtolower($obj->basic->person->neighborhood));

        $procurar[] = '$BASIC_PERSON_CITY_ID';
        $substituir[] = $obj->basic->person->cityId;

        $procurar[] = '$BASIC_PERSON_CITYNAME';
        $substituir[] = ucwords(strtolower($obj->basic->person->cityName));

        $procurar[] = '$BASIC_PERSON_STATE_ID';
        $substituir[] = $obj->basic->person->stateId;

        $procurar[] = '$BASIC_PERSON_STATE';
        $substituir[] =  ucwords(strtolower($obj->basic->person->state));

        $procurar[] = '$BASIC_PERSON_ZIPCODE';
        $substituir[] = $obj->basic->person->zipCode;

        $procurar[] = '$BASIC_PERSON_EMAIL_ALTERNATIVE';
        $substituir[] = strtolower($obj->basic->person->emailAlternative);

        $procurar[] = '$BASIC_PERSON_EMAIL';
        $substituir[] = strtolower($obj->basic->person->email);

        $procurar[] = '$BASIC_PERSON_DATE_BIRTH';
        $substituir[] = $obj->basic->person->dateBirth;

        $procurar[] = '$BASIC_PERSON_NATIONALITY';
        $substituir[] = ucwords(strtolower($obj->basic->person->nationality));

        $procurar[] = '$BASIC_PERSON_MARITAL_STATUS';
        $substituir[] = ucwords(strtolower($obj->basic->person->maritalStatus));

        $procurar[] = '$BASIC_PERSON_ETHNIC_ORIGIN';
        $substituir[] = ucwords(strtolower($obj->basic->person->ethnicOrigin));

        $procurar[] = '$BASIC_PERSON_CPF';
        $substituir[] = $obj->basic->person->cpf;

        $procurar[] = '$BASIC_PERSON_RG_EMISSION_DATE';
        $substituir[] = $obj->basic->person->rgEmissionDate;

        $procurar[] = '$BASIC_PERSON_RG_ORGAN';
        $substituir[] = $obj->basic->person->rgOrgan;

        $procurar[] = '$CONTRACT_RG_ORGAN';
        $substituir[] = $obj->basic->person->rgOrgan;

        $procurar[] = '$BASIC_PERSON_RG_CITY_ID';
        $substituir[] = $obj->basic->person->rgCityId;

        $procurar[] = '$BASIC_PERSON_RG_CITYNAME';
        $substituir[] =  ucwords(strtolower($obj->basic->person->rgCityOrgan));

        $procurar[] = '$BASIC_PERSON_RG_STATE_ID';
        $substituir[] = $obj->basic->person->rgUf;

        $procurar[] = '$BASIC_PERSON_RG';
        $substituir[] = $obj->basic->person->rg;

        $procurar[] = '$CONTRACT_RG';
        $substituir[] = $obj->basic->person->rg;
        
        $procurar[] = '$BASIC_PERSON_MOTHERNAME';
        $substituir[] =  ucwords(strtolower($obj->basic->person->mother));

        $procurar[] = '$BASIC_PERSON_FATHERNAME';
        $substituir[] =  ucwords(strtolower($obj->basic->person->father));

        $procurar[] = '$BASIC_PERSON_MOBILE';
        $substituir[] = $obj->basic->person->mobile;

        $procurar[] = '$BASIC_PERSON_WORKPHONE';
        $substituir[] = $obj->basic->person->workPhone;

        $procurar[] = '$BASIC_PERSON_RESIDENTIALPHONE';
        $substituir[] = $obj->basic->person->residentialPhone;

        $procurar[] = '$BASIC_PERSON_MESSAGEPHONE';
        $substituir[] = $obj->basic->person->messagePhone;

        $procurar[] = '$BASIC_PERSON_CARPLATE';
        $substituir[] = $obj->basic->person->carPlate;

        $procurar[] = '$BASIC_PERSON_WORKNAME';
        $substituir[] = $obj->basic->person->workName;

        $procurar[] = '$BASIC_PERSON_WORK_CITYID';
        $substituir[] = $obj->basic->person->workCityId;

        $procurar[] = '$BASIC_PERSON_WORK_CITYNAME';
        $substituir[] =  ucwords(strtolower($obj->basic->person->workCityName));

        $procurar[] = '$BASIC_PERSON_WORK_LOCATION';
        $substituir[] =  ucwords(strtolower($obj->basic->person->workLocation));

        $procurar[] = '$BASIC_PERSON_WORK_ZIPCODE';
        $substituir[] = $obj->basic->person->workZipCode;

        $procurar[] = '$BASIC_PERSON_WORK_NEIGHBORHOOD';
        $substituir[] =  ucwords(strtolower($obj->basic->person->workNeighborhood));

        $procurar[] = '$BASIC_PERSON_WORK_COMPLEMENT';
        $substituir[] = $obj->basic->person->workComplement;

        $procurar[] = '$BASIC_PERSON_DEATH_DATE';
        $substituir[] = $obj->basic->person->deathDate;

        $procurar[] = '$BASIC_PERSON_SPECIAL_NECESSITY_DESCRIPTION';
        $substituir[] =  ucwords(strtolower($obj->basic->person->specialNecessityDescription));

        $procurar[] = '$BASIC_PERSON_SPECIAL_NECESSITY';
        $substituir[] =  ucwords(strtolower($obj->basic->person->specialNecessity));

        //RESPONSABLE
        $procurar[] = '$BASIC_RESPONSABLE_PERSON_ID';
        $substituir[] = $obj->basic->responsable->personId;

        $procurar[] = '$BASIC_RESPONSABLE_PERSON_TITLE';
        $substituir[] = $obj->basic->responsable->personTitle;

        $procurar[] = '$BASIC_RESPONSABLE_NAME';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->name));

        $procurar[] = '$BASIC_RESPONSABLE_SEX';
        $substituir[] = $obj->basic->responsable->sex;

        $procurar[] = '$BASIC_RESPONSABLE_NICKNAME';
        $substituir[] = $obj->basic->responsable->nickName;

        $procurar[] = '$BASIC_RESPONSABLE_LOCATION';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->location));

        $procurar[] = '$BASIC_RESPONSABLE_NUMBER';
        $substituir[] = $obj->basic->responsable->number;

        $procurar[] = '$BASIC_RESPONSABLE_NEIGHBORHOOD';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->neighborhood));

        $procurar[] = '$BASIC_RESPONSABLE_CITY_ID';
        $substituir[] = $obj->basic->responsable->cityId;

        $procurar[] = '$BASIC_RESPONSABLE_CITYNAME';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->cityName));

        $procurar[] = '$BASIC_RESPONSABLE_STATE_ID';
        $substituir[] = $obj->basic->responsable->stateId;

        $procurar[] = '$BASIC_RESPONSABLE_STATE';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->state));

        $procurar[] = '$BASIC_RESPONSABLE_ZIPCODE';
        $substituir[] = $obj->basic->responsable->zipCode;

        $procurar[] = '$BASIC_RESPONSABLE_EMAIL_ALTERNATIVE';
        $substituir[] = strtolower($obj->basic->responsable->emailAlternative);

        $procurar[] = '$BASIC_RESPONSABLE_EMAIL';
        $substituir[] = strtolower($obj->basic->responsable->email);

        $procurar[] = '$BASIC_RESPONSABLE_DATE_BIRTH';
        $substituir[] = $obj->basic->responsable->dateBirth;

        $procurar[] = '$BASIC_RESPONSABLE_NATIONALITY';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->nationality));

        $procurar[] = '$BASIC_RESPONSABLE_MARITAL_STATUS';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->maritalStatus));

        $procurar[] = '$BASIC_RESPONSABLE_ETHNIC_ORIGIN';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->ethnicOrigin));

        $procurar[] = '$BASIC_RESPONSABLE_CPF';
        $substituir[] = $obj->basic->responsable->cpf;

        $procurar[] = '$BASIC_RESPONSABLE_RG_EMISSION_DATE';
        $substituir[] = $obj->basic->responsable->rgEmissionDate;

        $procurar[] = '$BASIC_RESPONSABLE_RG_ORGAN';
        $substituir[] = $obj->basic->responsable->rgOrgan;

        $procurar[] = '$BASIC_RESPONSABLE_RG_CITY_ID';
        $substituir[] = $obj->basic->responsable->rgCityId;

        $procurar[] = '$BASIC_RESPONSABLE_RG_CITYNAME';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->rgCityOrgan));

        $procurar[] = '$BASIC_RESPONSABLE_RG_STATE_ID';
        $substituir[] = $obj->basic->responsable->rgUf;

        $procurar[] = '$BASIC_RESPONSABLE_RG';
        $substituir[] = $obj->basic->responsable->rg;

        $procurar[] = '$BASIC_RESPONSABLE_MOTHERNAME';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->mother));

        $procurar[] = '$BASIC_RESPONSABLE_FATHERNAME';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->father));

        $procurar[] = '$BASIC_RESPONSABLE_MOBILE';
        $substituir[] = $obj->basic->responsable->mobile;

        $procurar[] = '$BASIC_RESPONSABLE_WORKPHONE';
        $substituir[] = $obj->basic->responsable->workPhone;

        $procurar[] = '$BASIC_RESPONSABLE_RESIDENTIALPHONE';
        $substituir[] = $obj->basic->responsable->residentialPhone;

        $procurar[] = '$BASIC_RESPONSABLE_MESSAGEPHONE';
        $substituir[] = $obj->basic->responsable->messagePhone;

        $procurar[] = '$BASIC_RESPONSABLE_CARPLATE';
        $substituir[] = $obj->basic->responsable->carPlate;

        $procurar[] = '$BASIC_RESPONSABLE_WORKNAME';
        $substituir[] = $obj->basic->responsable->workName;

        $procurar[] = '$BASIC_RESPONSABLE_WORK_CITYID';
        $substituir[] = $obj->basic->responsable->workCityId;

        $procurar[] = '$BASIC_RESPONSABLE_WORK_CITYNAME';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->workCityName));

        $procurar[] = '$BASIC_RESPONSABLE_WORK_LOCATION';
        $substituir[] =  ucwords(strtolower($obj->basic->responsable->workLocation));

        $procurar[] = '$BASIC_RESPONSABLE_WORK_ZIPCODE';
        $substituir[] = $obj->basic->responsable->workZipCode;

        $procurar[] = '$BASIC_RESPONSABLE_WORK_NEIGHBORHOOD';
        $substituir[] = $obj->basic->responsable->workNeighborhood;

        $procurar[] = '$BASIC_RESPONSABLE_WORK_COMPLEMENT';
        $substituir[] = $obj->basic->responsable->workComplement;

        $procurar[] = '$BASIC_RESPONSABLE_DEATH_DATE';
        $substituir[] = $obj->basic->responsable->deathDate;

        $procurar[] = '$BASIC_RESPONSABLE_SPECIAL_NECESSITY_DESCRIPTION';
        $substituir[] = $obj->basic->responsable->specialNecessityDescription;

        $procurar[] = '$BASIC_RESPONSABLE_SPECIAL_NECESSITY';
        $substituir[] = $obj->basic->responsable->specialNecessity;
        
        //LEGAL PERSON
        $procurar[] = '$BASIC_LEGALPERSON_CNPJ';
        $substituir[] = $this->pdfInfo->legalPerson->cnpj;

        $procurar[] = '$LEGALPERSON_CNPJ';
        $substituir[] = $this->pdfInfo->legalPerson->cnpj;

        $procurar[] = '$BASIC_LEGALPERSON_ADDRESS';
        $substituir[] = $this->pdfInfo->legalPersonAddress;
        
        $procurar[] = '$BASIC_LEGALPERSON_NAME';
        $substituir[] = $this->pdfInfo->legalPerson->name;

        $procurar[] = '$BASIC_LEGALPERSON_SHORTNAME';
        $substituir[] = $this->pdfInfo->legalPerson->shortName;

        //COMPANY
        $procurar[] = '$BASIC_COMPANY_NAME';
        $substituir[] = $this->pdfInfo->company->name;

        $procurar[] = '$BASIC_COMPANY_SHORTNAME';
        $substituir[] = $this->pdfInfo->company->acronym;
        
       // echo "<pre>"; print_r($this->pdfInfo);
       // die("<br>Legal: ".$this->pdfInfo->company->legalResponsableName);
        
        $procurar[] = '$BASIC_COMPANY_RESPONSABLE_LEGAL';
        $substituir[] = $this->pdfInfo->company->legalResponsableName;

        //GENERAL
        $procurar[] = '$CURDAY';
        $substituir[] = date('d');

        $procurar[] = '$CURMONTH_DESCRIPTON';
        $substituir[] =  _M(date('F'), 'basic');

        $procurar[] = '$CURMONTH';
        $substituir[] = date('m');

        $procurar[] = '$CURYEAR_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive(date('Y')));

        $procurar[] = '$CURYEAR';
        $substituir[] = date('Y');

        $procurar[] = '$PERIOD';
        $substituir[] = CURRENT_PERIOD_ID;


        //SELECTIVE_PROCESS
        
        $procurar[] = '$SELECTIVE_PROCESS_PERSON_NAME';
        $substituir[] = $obj->inscriptions[0][2];
        
        $procurar[] = '$SELECTIVE_PROCESS_PERSON_RG_ORGAN';
        $substituir[] = $obj->inscriptions[0][5];
        
        $procurar[] = '$SELECTIVE_PROCESS_PERSON_RG';
        $substituir[] = $obj->inscriptions[0][4];
        
        $procurar[] = '$SELECTIVE_PROCESS_PERSON_CPF';
        $substituir[] = $obj->inscriptions[0][7];
        
        $procurar[] = '$SELECTIVE_PROCESS_PERSON_LOCATION';
        $substituir[] = $obj->inscriptions[0][10];
        
        $procurar[] = '$SELECTIVE_PROCESS_PERSON_NUMBER';
        $substituir[] = $obj->inscriptions[0][11];
        
        $procurar[] = '$SELECTIVE_PROCESS_PERSON_COMPLEMENT';
        $substituir[] = $obj->inscriptions[0][12];
        
        $procurar[] = '$SELECTIVE_PROCESS_PERSON_NEIGHBORHOOD';
        $substituir[] = $obj->inscriptions[0][13];
        
        $procurar[] = '$SELECTIVE_PROCESS_COURSENAME';
        $substituir[] = $obj->coursesOptions[0][1];
        
        $procurar[] = '$SELECTIVE_PROCESS_COURSE_TURN_DESCRIPTION';
        $substituir[] = $obj->coursesOptions[0][3];
        
        $procurar[] = '$SELECTIVE_PROCESS_FEE_EXTENSIVE';
        $substituir[] = strtolower(SAGU::extensive($obj->coursesOptions[0][4], 'M', true));
        
        $procurar[] = '$SELECTIVE_PROCESS_FEE';
        $substituir[] = SAGU::formatNumber($obj->coursesOptions[0][4], true);
        
        $procurar[] = '$SELECTIVE_PROCESS_BEGIN_DATE';
        $substituir[] = $obj->coursesOptions[0][10];
        
        $procurar[] = '$SELECTIVE_PROCESS_UNITY_LOCATION';
        $substituir[] = $obj->coursesOptions[0][7];
        
        $procurar[] = '$SELECTIVE_PROCESS_UNITY_NUMBER';
        $substituir[] = $obj->coursesOptions[0][8];
        
        $procurar[] = '$SELECTIVE_PROCESS_UNITY_NEIGHBORHOOD';
        $substituir[] = $obj->coursesOptions[0][9];
        
        $procurar[] = '$SELECTIVE_PROCESS_UNITY';
        $substituir[] = $obj->coursesOptions[0][6];
        
        
        
        
        
        
       
        
        $this->procurar = $procurar;
        $this->substituir = $substituir;
        
//	MIOLO::vd($this->procurar);
//	MIOLO::vd($this->substituir);
    }
}
?>
