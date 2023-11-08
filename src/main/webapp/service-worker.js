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
    openDB(data.categoryPush, DB_VERSION, data.categoryPush).then(db => {
        checkAndAddNotification(db, data.id, data.categoryPush).then(result => {
            if (result.shouldNotify) {
                self.registration.showNotification(data.categoryPush, {
                        body: data.title,
                        icon: `/assets/images/icon-${data.categoryPush=="Notifications" ?"push":"event" }.png`,
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

self.addEventListener('notificationclick', function(event) {
    console.log('[Service Worker] Notification click Received.');
    event.notification.close();
    event.waitUntil(
        self.client.openWindow('https://example.com', '_blank')
    );
});

// let notification = new Notification(data.categoryPush, {
//     icon: "/assets/images/icon-push.png",
//     body: data.title,
//     requireInteraction: true,
//     tag: data.categoryPush,
//     renotify: true
// });
// notification.onclick = function () {
//     window.open('/' + data.categoryPush.toLowerCase() + '/' + data.id, '_blank');
// };