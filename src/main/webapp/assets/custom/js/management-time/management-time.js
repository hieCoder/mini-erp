const panels = document.querySelectorAll('.panel');

panels.forEach((panel, index) => {
    const pickrContainer = panel.querySelector('.pickr');
    const pickedColor = panel.querySelector('.pickedColor');
    const pickr = new Pickr({
        el: pickrContainer,
        default: '#42445A',
        theme: 'classic',
        swatches: [
            'rgba(244, 67, 54, 1)',
            'rgba(233, 30, 99, 0.95)',
            'rgba(156, 39, 176, 0.9)',
            'rgba(103, 58, 183, 0.85)',
            'rgba(63, 81, 181, 0.8)',
            'rgba(33, 150, 243, 0.75)',
            'rgba(3, 169, 244, 0.7)',
            'rgba(0, 188, 212, 0.7)',
            'rgba(0, 150, 136, 0.75)',
            'rgba(76, 175, 80, 0.8)',
            'rgba(139, 195, 74, 0.85)',
            'rgba(205, 220, 57, 0.9)',
            'rgba(255, 235, 59, 0.95)',
            'rgba(255, 193, 7, 1)'
        ],

        components: {
            preview: true,
            opacity: true,
            hue: true,

            interaction: {
                hex: true,
                rgba: true,
                hsva: true,
                input: true,
                save: true
            }
        }
    }).on('init', pickr => {
        pickrContainer.value = pickr.getSelectedColor().toRGBA().toString(0);
    }).on('save', color => {
        pickedColor.textContent = color.toRGBA().toString(0);
        pickr.hide();
    }).on('change', color => {
        pickedColor.textContent = color.toRGBA().toString(0);
        panel.style.backgroundColor = color.toRGBA().toString(0);
    });
});
