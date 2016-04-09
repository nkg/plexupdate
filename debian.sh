echo "On Debian"
echo "Patching release"
VERSION=${DOWNLOAD%"/"$FILENAME}
VERSION=${VERSION##*/}
FOLDER=${FILENAME%.*}
dpkg -x "${DOWNLOADDIR}/${FILENAME}" "${DOWNLOADDIR}/${FOLDER}"
tar xvfj  "${SCRIPTPATH}/amd64.tar.bz2 -C ${DOWNLOADDIR}"
mv "${DOWNLOADDIR}/${FOLDER}/usr" "${DOWNLOADDIR}/amd64/debian"
sed -i "s#{{version}}#${VERSION}#" "${DOWNLOADDIR}/amd64/debian/DEBIAN/control"
sudo dpkg-deb --build "${DOWNLOADDIR}/amd64/debian"
sudo dpkg -i "${DOWNLOADDIR}/amd64/debian.deb"
echo "Removing build files"
rm -rf "${DOWNLOADDIR}/amd64"
rm -rf "${DOWNLOADDIR}/${FOLDER}"
