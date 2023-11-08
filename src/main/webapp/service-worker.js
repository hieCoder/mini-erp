const DB_NAME = 'pushDB';
const DB_VERSION = 1;

function openDB(DB_NAME, DB_VERSION ,STORE_NAME) {
    return new Promise((resolve, reject) => {
        console.log(DB_NAME)
        console.log(DB_VERSION)
        console.log(STORE_NAME)
        const request = indexedDB.open(DB_NAME, DB_VERSION);

        request.onupgradeneeded = event => {
            let db = event.target.result;
            db.createObjectStore(STORE_NAME, { keyPath: 'id' });
        };

        request.onerror = event => {
            reject('IndexedDB error: ' + event.target.errorCode);
        };

        request.onsuccess = event => {
            resolve(event.target.result);
        };
    });
}

function checkAndAddNotification(db, id, STORE_NAME) {
    return new Promise((resolve, reject) => {
        const transaction = db.transaction(STORE_NAME, 'readwrite');
        const store = transaction.objectStore(STORE_NAME);
        const request = store.get(id);

        request.onsuccess = event => {
            const data = event.target.result;
            if (!data) {
                store.add({ id: id });
                resolve({ shouldNotify: true });
            } else {
                resolve({ shouldNotify: false });
            }
        };

        request.onerror = event => {
            reject('Error in checkAndAddNotification.');
        };
    });
}

self.addEventListener('message', function(event) {
    let data = event.data.data
    openDB(DB_NAME, DB_VERSION, data.categoryPush).then(db => {
        checkAndAddNotification(db, data.id, data.categoryPush).then(result => {
            if (result.shouldNotify) {
                self.registration.showNotification(data.categoryPush, {
                        body: data.title,
                        icon: '/assets/images/icon-event.png',
                        tag: data.categoryPush,
                        renotify: true,
                        requireInteraction: true,
                    }).then(r => {
                        console.log("Show push success")
                    });
            }
        });
    }).catch(error => {
        console.error('Could not manage IndexedDB', error);
    });
});