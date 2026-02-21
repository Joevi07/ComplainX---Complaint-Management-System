
function openTrackModal() {
    document.getElementById("trackModal").style.display="flex";
}
function closeTrackModal() {
    document.getElementById("trackModal").style.display="none";
}

function trackComplaint() {
    let id = document.getElementById("trackId").value;
    fetch("trackComplaint.jsp?cid="+id)
        .then(res=>res.text())
        .then(data=>{
            document.getElementById("trackResult").innerHTML=data;
        });
}
