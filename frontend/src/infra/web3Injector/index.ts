import { RainbowKitProvider, getDefaultWallets } from '@rainbow-me/rainbowkit';
import { chain, configureChains, createClient } from 'wagmi';
import { alchemyProvider } from 'wagmi/providers/alchemy';
import { infuraProvider } from 'wagmi/providers/infura';
import { publicProvider } from 'wagmi/providers/public';

export const { chains, provider, webSocketProvider } = configureChains(
  [
    chain.goerli,
    chain.mainnet,
    chain.polygon,
    chain.polygonMumbai,
  ],
  [
    alchemyProvider({ apiKey: "" }),
    infuraProvider({apiKey: ""}),
    publicProvider()
  ]
);

export const { connectors } = getDefaultWallets({
  appName: 'OmnesBlockchain App',
  chains,
});

export const wagmiClient = createClient({
  autoConnect: true,
  connectors,
  provider,
  webSocketProvider,
});

export default  RainbowKitProvider
