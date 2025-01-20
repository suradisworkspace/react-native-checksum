import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  getBundleChecksum(): string;
  getChecksumFile(filePath: string): string;
}

export default TurboModuleRegistry.getEnforcing<Spec>('Checksum');
