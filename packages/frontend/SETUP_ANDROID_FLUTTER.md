# Configuration Android Studio + Émulateur Android pour Flutter

## Audit de l'état actuel

| Composant                                      | Statut                                               |
| ---------------------------------------------- | ---------------------------------------------------- |
| **Flutter SDK** (3.41.9)                       | ✅ Installé                                          |
| **Android Studio** (2025.1.3 snap)             | ✅ Installé                                          |
| **Android SDK** (platform android-36)          | ✅ Installé                                          |
| **Build-tools** (36.1.0, 37.0.0)               | ✅ Installé                                          |
| **Platform-tools** (adb, fastboot)             | ✅ Installé                                          |
| **Emulator binaire** (36.5.11.0)               | ✅ Installé                                          |
| **JDK / Java** (bundlé dans Android Studio 21) | ✅ Disponible                                        |
| **KVM** (`/dev/kvm` présent)                   | ✅ Disponible                                        |
| **cmdline-tools** (`sdkmanager`)               | ❌ Manquant                                          |
| **Licences Android**                           | ❌ Non acceptées                                     |
| **System images** (pour l'émulateur)           | ❌ Aucune installée                                  |
| **AVD** (émulateur virtuel)                    | ❌ Aucun créé                                        |
| **User dans le groupe kvm**                    | ❌ Non                                               |
| **qemu-kvm**                                   | ❌ Non installé                                      |
| **Connexion appareil réel**                    | ⚠️ Permissions insuffisantes (udev rules manquantes) |
| **ANDROID_HOME**                               | ❌ Non défini                                        |

---

## Guide pas à pas

### 1. Définir la variable d'environnement `ANDROID_HOME`

Ajouter dans `~/.bashrc` ou `~/.zshrc` :

- [ ] Exécuter :
  ```bash
  echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
  echo 'export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin' >> ~/.bashrc
  source ~/.bashrc
  ```

### 2. Installer `cmdline-tools` (sdkmanager en CLI)

- [ ] Lancer Android Studio (snap) :

  ```bash
  android-studio
  ```

- [ ] Aller dans **SDK Manager** (icône SDK dans le bandeau supérieur ou via `More Actions > SDK Manager`)
- [ ] Dans l'onglet **SDK Tools**, cocher **Android SDK Command-line Tools (latest)**
- [ ] Cliquer **Apply/OK** pour installer

  **Alternative en CLI :**

  ```bash
  mkdir -p $ANDROID_HOME/cmdline-tools
  cd /tmp
  wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
  unzip commandlinetools-linux-*.zip
  mv cmdline-tools $ANDROID_HOME/cmdline-tools/latest
  rm commandlinetools-linux-*.zip
  ```

- [ ] Vérifier :
  ```bash
  sdkmanager --list
  ```

### 3. Activer la virtualisation matérielle (KVM)

- [ ] Installer qemu-kvm :

  ```bash
  sudo apt update && sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
  ```

- [ ] Ajouter votre utilisateur au groupe `kvm` et `libvirt` :

  ```bash
  sudo usermod -aG kvm $USER
  sudo usermod -aG libvirt $USER
  ```

- [ ] **Déconnectez-vous puis reconnectez-vous** (ou `newgrp kvm && newgrp libvirt`) pour que les groupes prennent effet

- [ ] Vérifier :
  ```bash
  groups  # doit contenir kvm et libvirt
  ls -la /dev/kvm  # doit être accessible sans sudo
  ```

### 4. Accepter les licences Android

- [ ] Accepter toutes les licences :
  ```bash
  flutter doctor --android-licenses
  ```
  (Taper `y` à chaque prompt)

### 5. Installer une System Image pour l'émulateur

Décider une API cible (android-36 = Android 16, ou android-35 = Android 15).

- [ ] Depuis Android Studio : **SDK Manager > SDK Platforms** → cocher **Google APIs ARM 64 v2** (ou x86_64) pour l'API level souhaité

  **Alternative CLI :**

  ```bash
  # Lister les images disponibles
  sdkmanager --list | grep system-images

  # Installer une image ARM64 (recommandé pour compatibilité)
  sdkmanager "system-images;android-36;google_apis;arm64-v8a"

  # Ou x86_64 (plus rapide sur Intel)
  sdkmanager "system-images;android-36;google_apis;x86_64"
  ```

- [ ] Vérifier :
  ```bash
  ls $ANDROID_HOME/system-images/
  ```

### 6. Créer un AVD (émulateur virtuel)

- [ ] Via Android Studio : **AVD Manager** (icône téléphone dans le bandeau) > **Create Virtual Device** > choisir un modèle (Pixel 9, Pixel 8, etc.) > sélectionner l'image système installée > **Finish**

- [ ] **Alternative CLI :**

  ```bash
  echo "no" | avdmanager create avd -n Pixel_9 -k "system-images;android-36;google_apis;arm64-v8a" -d pixel_9
  ```

- [ ] Vérifier :
  ```bash
  flutter emulators
  ```
  Vous devez voir votre nouvel AVD listé.

### 7. Lancer l'émulateur et tester

- [ ] Démarrer l'émulateur :

  ```bash
  flutter emulators --launch Pixel_9
  # ou depuis Android Studio : AVD Manager > Play (▶)
  ```

- [ ] Vérifier que le device est détecté :

  ```bash
  flutter devices
  ```

- [ ] Lancer votre app Flutter :
  ```bash
  flutter run
  ```

### 8. (Optionnel) Configurer un appareil Android réel

Si vous branchez un vrai téléphone Android :

- [ ] Activer le **Mode Développeur** sur le téléphone :
      Paramètres > À propos du téléphone > appuyer 7 fois sur **Numéro de build**

- [ ] Activer **Débogage USB** dans les Options développeur

- [ ] Créer les règles udev pour les permissions Linux :

  ```bash
  sudo tee /etc/udev/rules.d/51-android.rules << 'EOF'
  SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"
  SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
  SUBSYSTEM=="usb", ATTR{idVendor}=="22b8", MODE="0666", GROUP="plugdev"
  SUBSYSTEM=="usb", ATTR{idVendor}=="1004", MODE="0666", GROUP="plugdev"
  SUBSYSTEM=="usb", ATTR{idVendor}=="0bb4", MODE="0666", GROUP="plugdev"
  SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", MODE="0666", GROUP="plugdev"
  SUBSYSTEM=="usb", ATTR{idVendor}=="8087", MODE="0666", GROUP="plugdev"
  SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", MODE="0666", GROUP="plugdev"
  SUBSYSTEM=="usb", ATTR{idVendor}=="2717", MODE="0666", GROUP="plugdev"
  EOF
  ```

- [ ] Recharger les règles udev :

  ```bash
  sudo udevadm control --reload-rules
  sudo udevadm trigger
  ```

- [ ] Ajouter l'utilisateur aux groupes `plugdev` et `adbusers` :

  ```bash
  sudo usermod -aG plugdev $USER
  # Deconnecter/reconnecter
  ```

- [ ] Redémarrer le serveur adb :
  ```bash
  adb kill-server
  adb start-server
  adb devices
  ```

### 9. Vérification finale

- [ ] Exécuter :
  ```bash
  flutter doctor -v
  ```
  Toutes les lignes **Android toolchain** et **Android Studio** doivent avoir une coche verte **✓**.

---

## Résumé des commandes essentielles

```bash
# Installation qemu-kvm
sudo apt install -y qemu-kvm libvirt-daemon-system
sudo usermod -aG kvm $USER

# Environnement
echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin' >> ~/.bashrc
source ~/.bashrc

# Licences
flutter doctor --android-licenses

# Installer system image et créer AVD
sdkmanager "system-images;android-36;google_apis_arm64;android-tv"
echo "no" | avdmanager create avd -n Pixel_9 -k "system-images;android-36;google_apis_arm64" -d pixel_9

# Lancer
flutter emulators --launch Pixel_9
flutter run
```
