.header {
    background-color: black;
    border-radius: 25px;
    width: 100%; /* Ensure the header spans the full width of the page */
    margin: 0; /* Remove default margins */
    padding: 0px; /* Optional: Add padding for content spacing */
    box-sizing: border-box; /* Ensure padding and border are included in the width */
}

/* Media query for screens smaller than 360px */
@media (max-width: 360px) {
    .header {
        margin-bottom: 80px; /* Increased margin bottom on smaller screens */
    }
    .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between; /* Space between logo and items */
            padding: 0 30px; /* Adjust padding as needed */
            margin-bottom:150px;
        }
}