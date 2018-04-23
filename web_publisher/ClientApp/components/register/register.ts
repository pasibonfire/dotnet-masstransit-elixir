import Vue from 'vue';
import { Component } from 'vue-property-decorator';

@Component
export default class RegisterComponent extends Vue {
    extId: string = "";
    to: string = "";

    registerShipment() {

        var http = new XMLHttpRequest();
        var url = "api/shipment/";
        var shipment = { to: this.to, from: "Vue+dotnet", externalId: this.extId };
        var params = JSON.stringify(shipment);
        http.open("POST", url, true);

        //Send the proper header information along with the request
        http.setRequestHeader("Content-type", "application/json");

        http.onreadystatechange = function () {//Call a function when the state changes.
            if (http.readyState == 4 && http.status == 200) {
                alert(http.responseText);
            }
        }
        http.send(params);

        this.clearForm();

    }

    clearForm() {
        this.to = "";
        this.extId = "";
        // this.$refs.recipient.focus()
        // this.$nextTick(() => this.$refs.recipient.focus())
        var input = document.getElementById("recipient")
        if (null != input) 
            input.focus();
    }
}
