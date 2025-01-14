document.addEventListener('DOMContentLoaded', function() {
    const materialsList = document.getElementById('materials-list');
    
    // Initial fetch for the main repository contents
    fetch('https://api.github.com/repos/BastionDevs/unPlugged/contents')
        .then(response => response.json())
        .then(data => {
            const container = document.createElement('div');
            container.className = 'file-container';
            
            // Define the allowed folder names
            const allowedFolders = ['bypsrc', 'pldsrc'];
            
            data.forEach(item => {
                // Check if item is a folder with an allowed name
                if (item.type === 'dir' && allowedFolders.includes(item.name)) {
                    const box = createFileBox(item);
                    container.appendChild(box);
                }
            });
            
            materialsList.innerHTML = '';
            materialsList.appendChild(container);
        })
        .catch(error => {
            console.error('Error fetching repository contents:', error);
            materialsList.textContent = 'Error loading repository contents. Please try again later.';
        });
});

function createFileBox(item) {
    const box = document.createElement('div');
    box.className = 'file-box';
    
    const icon = document.createElement('div');
    icon.className = 'file-icon ' + (item.type === 'dir' ? 'folder-icon' : 'file-icon');
    
    const name = document.createElement('div');
    name.className = 'file-name';
    
    const nameWithoutExtension = item.name.replace(/\.[^/.]+$/, "");
    name.textContent = nameWithoutExtension;
    
    box.appendChild(icon);
    box.appendChild(name);
    
    box.onclick = function() {
        if (item.type === 'file') {
            loadFile(item.download_url);
        } else if (item.type === 'dir') {
            loadDirectory(item.url);  // Load directory contents
        }
    };
    
    return box;
}

function loadFile(url) {
    fetch(url)
        .then(response => response.text())
        .then(content => {
            const contentDiv = document.createElement('div');
            contentDiv.textContent = content;
            const materialsList = document.getElementById('materials-list');
            materialsList.innerHTML = '';
            materialsList.appendChild(contentDiv);
        })
        .catch(error => {
            console.error('Error loading file:', error);
            document.getElementById('materials-list').textContent = 'Error loading file. Please try again later.';
        });
}

function loadDirectory(url) {
    fetch(url)
        .then(response => response.json())
        .then(data => {
            const container = document.createElement('div');
            container.className = 'file-container';
            
            data.forEach(item => {
                const box = createFileBox(item);  // Create boxes for each item
                container.appendChild(box);
            });
            
            const materialsList = document.getElementById('materials-list');
            materialsList.innerHTML = '';
            materialsList.appendChild(container);
        })
        .catch(error => {
            console.error('Error loading directory:', error);
            document.getElementById('materials-list').textContent = 'Error loading directory. Please try again later.';
        });
}
