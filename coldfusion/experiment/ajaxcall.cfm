<cfajaxproxy cfc="coldfusion.experiment.components.something" jsclassname="jsClass">
<script type="text/javascript">
    var _myFuncs = new jsClass();

    function buttonClicked(arg) {
       alert(_myFuncs.abc(arg));
    }

</script>
<button onclick="buttonClicked('hello world!')">Click !</button>