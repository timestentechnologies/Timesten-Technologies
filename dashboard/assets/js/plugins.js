(function() {
    var needsToastify = document.querySelectorAll("[toast-list]").length > 0;
    var needsChoices = document.querySelectorAll("[data-choices]").length > 0;
    var needsFlatpickr = document.querySelectorAll("[data-provider]").length > 0;
    
    if (needsToastify || needsChoices || needsFlatpickr) {
        var scripts = [];
        if (needsToastify) {
            scripts.push({ src: 'https://cdn.jsdelivr.net/npm/toastify-js', async: true });
        }
        if (needsChoices) {
            scripts.push({ src: 'https://cdn.jsdelivr.net/npm/choices.js@10.2.0/public/assets/scripts/choices.min.js', async: true });
        }
        if (needsFlatpickr) {
            scripts.push({ src: 'https://cdn.jsdelivr.net/npm/flatpickr@4.6.13/dist/flatpickr.min.js', async: true });
        }
        
        scripts.forEach(function(s) {
            var script = document.createElement('script');
            script.type = 'text/javascript';
            script.src = s.src;
            if (s.async) script.async = true;
            document.head.appendChild(script);
        });
    }
})();