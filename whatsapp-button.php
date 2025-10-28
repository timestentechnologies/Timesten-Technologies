<?php
// WhatsApp button configuration
$whatsapp_number = "254700000000"; // Replace with your actual WhatsApp number
?>

<!-- WhatsApp Button Styles -->
<style>
.whatsapp-btn {
    position: fixed;
    bottom: 20px;
    left: 20px;
    z-index: 99999;
    background-color: #25D366;
    color: white;
    border-radius: 50%;
    width: 60px;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 10px rgba(0,0,0,0.3);
    transition: transform 0.3s ease;
    text-decoration: none;
}

.whatsapp-btn:hover {
    transform: scale(1.1);
    color: white;
    text-decoration: none;
}

.whatsapp-btn i {
    font-size: 35px;
}
</style>

<!-- WhatsApp Button -->
<a href="https://wa.me/<?php echo $whatsapp_number; ?>" target="_blank" class="whatsapp-btn">
    <i class="fab fa-whatsapp"></i>
</a> 