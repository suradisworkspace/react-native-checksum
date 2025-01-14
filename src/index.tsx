import Checksum from './NativeChecksum';

export function getBundleChecksum(): string {
  return Checksum.getBundleChecksum();
}

export function getChecksumFile(filePath: string): string {
  return Checksum.getChecksumFile(filePath);
}

export default {
  getBundleChecksum,
  getChecksumFile,
};
