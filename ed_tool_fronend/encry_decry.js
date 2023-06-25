// const encryptForm = document.getElementById('encrypt-form');
// const fileUpload = document.getElementById('file-upload');
// const encryptionKey = document.getElementById('encryption-key');
// const encryptError = document.getElementById('encrypt-error');
// const downloadLink = document.getElementById('download-link');
// const decryptForm = document.getElementById('decrypt-form');
// const fileUploadEncrypted = document.getElementById('file-upload-encrypted');
// const decryptionKey = document.getElementById('decryption-key');
// const decryptError = document.getElementById('decrypt-error');

// encryptForm.addEventListener('submit', async (event) => {
//   event.preventDefault();
//   encryptError.textContent = '';
//   downloadLink.innerHTML = '';
//   const file = fileUpload.files[0];
//   const key = encryptionKey.value;
//   const encryptedFile = await encryptFile(file, key);
//   if (encryptedFile) {
//     downloadLink.innerHTML = `<a href="${URL.createObjectURL(encryptedFile)}" download="${file.name}.enc">Download encrypted file</a>`;
//   } else {
//     encryptError.textContent = 'Encryption failed';
//   }
// });

// decryptForm.addEventListener('submit', async (event) => {
//   event.preventDefault();
//   decryptError.textContent = '';
//   const file = fileUploadEncrypted.files[0];
//   constkey = decryptionKey.value;
//   const decryptedFile = await decryptFile(file, key);
//   if (decryptedFile) {
//     downloadLink.innerHTML = `<a href="${URL.createObjectURL(decryptedFile)}" download="${file.name.slice(0, -4)}">Download decrypted file</a>`;
//   } else {
//     decryptError.textContent = 'Decryption failed';
//   }
// });

// async function encryptFile(file, key) {
//   try {
//     const fileBuffer = await file.arrayBuffer();
//     const encryptedBuffer = await crypto.subtle.encrypt({name: 'AES-CBC', iv: crypto.getRandomValues(new Uint8Array(16))}, await crypto.subtle.importKey('raw', new TextEncoder().encode(key), {name: 'PBKDF2'}, false, ['encrypt']), fileBuffer);
//     return new Blob([encryptedBuffer]);
//   } catch (error) {
//     console.error(error);
//     return null;
//   }
// }

// async function decryptFile(file, key) {
//   try {
//     const fileBuffer = await file.arrayBuffer();
//     const decryptedBuffer = await crypto.subtle.decrypt({name: 'AES-CBC', iv: new Uint8Array(fileBuffer, 0, 16)}, await crypto.subtle.importKey('raw', new TextEncoder().encode(key), {name: 'PBKDF2'}, false, ['decrypt']), new Uint8Array(fileBuffer, 16));
//     return new Blob([decryptedBuffer]);
//   } catch (error) {
//     console.error(error);
//     return null;
//   }
// }


const encryptForm = document.getElementById('encrypt-form');
const fileUpload = document.getElementById('file-upload');
const encryptionKey = document.getElementById('encryption-key');
const encryptError = document.getElementById('encrypt-error');
const downloadLink = document.getElementById('download-link');

encryptForm.addEventListener('submit', async (event) => {
  event.preventDefault();
  encryptError.textContent = '';
  downloadLink.innerHTML = '';
  const file = fileUpload.files[0];
  const key = encryptionKey.value;
  const encryptedFile = await encryptFile(file, key);
  if (encryptedFile) {
    downloadLink.innerHTML = `<a href="${URL.createObjectURL(encryptedFile)}" download="${file.name}.enc">Download encrypted file</a>`;
  } else {
    encryptError.textContent = 'Encryption failed';
  }
});

async function encryptFile(file, key) {
  try {
    const fileBuffer = await file.arrayBuffer();
    const encryptedBuffer = await crypto.subtle.encrypt({name: 'AES-CBC', iv: crypto.getRandomValues(new Uint8Array(16))}, await crypto.subtle.importKey('raw', new TextEncoder().encode(key), {name: 'PBKDF2'}, false, ['encrypt']), fileBuffer);
    return new Blob([encryptedBuffer]);
  } catch (error) {
    console.error(error);
    return null;
  }
}