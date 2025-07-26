sap.ui.define([
    "sap/m/MessageToast"
], function (MessageToast) {
    "use strict";

    return {
        onUploadPress: function (oEvent) {
            var oVBox = oEvent.getSource().getParent();

            var oFileUploader = oVBox.getItems().find(function (item) {
                return item.getMetadata().getName().includes("FileUploader");
            });

            if (!oFileUploader) {
                MessageToast.show("FileUploader not found.");
                return;
            }

            var aFiles = oFileUploader.getDomRef("fu").files;

            if (!aFiles || aFiles.length === 0) {
                MessageToast.show("Please select a file first.");
                return;
            }

            var file = aFiles[0];
            var reader = new FileReader();

            reader.onload = function (e) {
                var base64Data = e.target.result.split(",")[1];

                var oPayload = {
                    fileName: file.name,
                    mimeType: file.type,
                    file: base64Data
                };

                var oModel = sap.ui.getCore().getModel("fileModel");
                oModel.create("/Resume", oPayload, {
                    success: function () {
                        MessageToast.show("File uploaded successfully.");
                        oFileUploader.clear();
                    },
                    error: function (oError) {
                        MessageToast.show("Upload failed: " + oError.message);
                    }
                });
            };

            reader.onerror = function () {
                MessageToast.show("Error reading file.");
            };

            reader.readAsDataURL(file);
        }
    };

});
