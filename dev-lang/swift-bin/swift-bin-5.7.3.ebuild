# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib-minimal

DESCRIPTION="Swift programming language from Apple"
HOMEPAGE="www.swift.org"

SRC_URI="https://download.swift.org/swift-${PV}-release/amazonlinux2/swift-${PV}-RELEASE/swift-${PV}-RELEASE-amazonlinux2.tar.gz"

S=${WORKDIR}

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

REQUIRED_USE=""
IUSE="repl icu"
RESTRICT="repl? ( strip )"

DEPEND="${PYTHON_DEPS}
		!!dev-lang/swift
		"
RDEPEND="${DEPEND}
		repl? ( !!dev-util/lldb )
		dev-lang/python:3.11.2_p2
		sys-devel/lld
		icu? ( dev-libs/icu-layoutex )
		dev-util/systemtap
		"

src_install() {
	
    ZIPDIR=swift-${PV}-RELEASE-amazonlinux2

	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/clang-13
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/clangd

	dosym clang-10 /usr/bin/clang
	dosym clang /usr/bin/clang++
	dosym clang /usr/bin/clang-cl
	dosym clang /usr/bin/clang-cpp

	if use repl; then
		dobin ${WORKDIR}/${ZIPDIR}/usr/bin/lldb
		dobin ${WORKDIR}/${ZIPDIR}/usr/bin/lldb-argdumper
		dobin ${WORKDIR}/${ZIPDIR}/usr/bin/lldb-server
	fi

	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/plutil
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/repl_swift
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/sourcekit-lsp
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-api-checker.py
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-build
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-build-sdk-interfaces
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-build-tool
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-demangle
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-driver
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-frontend
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-help
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-package
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-package-collection
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-run
	dobin ${WORKDIR}/${ZIPDIR}/usr/bin/swift-test

	dosym swift-frontend /usr/bin/swift
	dosym swift-frontend /usr/bin/swift-api-digester
	dosym swift-frontend /usr/bin/swift-api-extract
	dosym swift-frontend /usr/bin/swift-autolink-extract
	dosym swift-frontend /usr/bin/swiftc
	dosym swift-frontend /usr/bin/swift-symbolgraph-extract
	dosym swift-frontend /usr/bin/swift-symbolgraph-extract

	doheader -r ${WORKDIR}/${ZIPDIR}/usr/include

	dolib.so ${WORKDIR}/${ZIPDIR}/usr/lib/libIndexStore.so.13git
	dolib.so ${WORKDIR}/${ZIPDIR}/usr/lib/libsourcekitdInProc.so
	dolib.so ${WORKDIR}/${ZIPDIR}/usr/lib/libswiftDemangle.so
	
    if use repl; then
		dolib.so ${WORKDIR}/${ZIPDIR}/usr/lib/liblldb.so.13.0.0git
	fi

	insinto /usr/lib
	doins -r ${WORKDIR}/${ZIPDIR}/usr/lib/swift
	doins -r ${WORKDIR}/${ZIPDIR}/usr/lib/swift_static

	dosym libIndexStore.so.13git /usr/lib64/libIndexStore.so
	if use repl; then
		dosym liblldb.so.13.0.0git /usr/lib64/liblldb.so.13git
		dosym liblldb.so.13git /usr/lib64/liblldb.so
	fi

	dosym ../lib64/libIndexStore.so /usr/lib/libIndexStore.so
	dosym ../lib64/libIndexStore.so.13git /usr/lib/libIndexStore.so.13git
	if use repl; then
		dosym ../lib64/liblldb.so /usr/lib/liblldb.so
		dosym ../lib64/liblldb.so.13.0.0git /usr/lib/liblldb.so.13.0.0git
		dosym ../lib64/liblldb.so.13git /usr/lib/liblldb.so.13git
	fi
	dosym ../lib64/libsourcekitdInProc.so /usr/lib/libsourcekitdInProc.so
	dosym ../lib64/libswiftDemangle.so /usr/lib/libswiftDemangle.so

	insinto /usr/lib/clang/
	doins -r ${WORKDIR}/${ZIPDIR}/usr/lib/clang/13.0.0

	insinto /usr/local
	doins -r ${WORKDIR}/${ZIPDIR}/usr/local/include

	dodoc -r ${WORKDIR}/${ZIPDIR}/usr/share/doc/swift

	insinto /usr/share
	doins -r ${WORKDIR}/${ZIPDIR}/usr/share/icuswift
	doins -r ${WORKDIR}/${ZIPDIR}/usr/share/swift

	doman ${WORKDIR}/${ZIPDIR}/usr/share/man/man1/*.1
}
