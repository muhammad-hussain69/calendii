document.addEventListener("DOMContentLoaded", function() {
    let filterButton = document.getElementById("filter-button");
    let filterDate = document.getElementById("filter-date");

    let today = new Date().toISOString().split("T")[0];
    filterDate.value = today;

    filterEvents();

    filterButton.addEventListener("click", function(event) {
        event.preventDefault();
        filterEvents();
    });
});

function filterEvents() {
    let filterDate = document.getElementById("filter-date").value;
    let eventCards = document.getElementsByClassName("event-card");

    for (let i = 0; i < eventCards.length; i++) {
        let eventCard = eventCards[i];
        let startDate = eventCard.querySelector(".event-details p:nth-child(1)").innerText.trim();
        startDate = startDate.replace("Start: ", "");

        if (startDate === filterDate) {
            eventCard.style.display = "block";
        } else {
            eventCard.style.display = "none";
        }
    }
}

let refreshButton = document.getElementById("refresh-button");

refreshButton.addEventListener("click", function() {
    location.reload();
});