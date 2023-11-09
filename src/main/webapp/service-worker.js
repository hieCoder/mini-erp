const DB_VERSION = 1;

self.addEventListener('install', function(event) {
    event.waitUntil(
        self.skipWaiting()  // Đây là lệnh để bỏ qua việc chờ đợi
    );
});

function openDB(DB_NAME, DB_VERSION ,STORE_NAME) {
    return new Promise((resolve, reject) => {
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
                console.log(data)
                self.registration.showNotification(data.categoryPush, {
                        body: data.title,
                        icon: `/assets/images/icon-${data.categoryPush=="Notifications" ?"push":"event" }.png`,
                        tag: `${data.userId},${data.id}`,
                        id: data.id,
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
    let data = event.notification;
    let arrTag = data.tag ? data.tag.split(",") : []
    let url = "/"
    if(data.title == "Events"){
        url = "/schedules/detail/" + arrTag[0]
    }else if(data.title == "Notifications"){
        url = "/notifications/" + arrTag[1]
    }
    event.notification.close();
    event.waitUntil(
        self.clients.openWindow(url, '_blank')
    );
});
