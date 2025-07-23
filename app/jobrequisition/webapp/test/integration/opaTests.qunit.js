sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'jobrequisition/test/integration/FirstJourney',
		'jobrequisition/test/integration/pages/JobRequisitionList',
		'jobrequisition/test/integration/pages/JobRequisitionObjectPage',
		'jobrequisition/test/integration/pages/JobApplicationObjectPage'
    ],
    function(JourneyRunner, opaJourney, JobRequisitionList, JobRequisitionObjectPage, JobApplicationObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('jobrequisition') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheJobRequisitionList: JobRequisitionList,
					onTheJobRequisitionObjectPage: JobRequisitionObjectPage,
					onTheJobApplicationObjectPage: JobApplicationObjectPage
                }
            },
            opaJourney.run
        );
    }
);