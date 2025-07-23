sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'candidate/test/integration/FirstJourney',
		'candidate/test/integration/pages/CandiadteList',
		'candidate/test/integration/pages/CandiadteObjectPage'
    ],
    function(JourneyRunner, opaJourney, CandiadteList, CandiadteObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('candidate') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCandiadteList: CandiadteList,
					onTheCandiadteObjectPage: CandiadteObjectPage
                }
            },
            opaJourney.run
        );
    }
);