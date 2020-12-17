import { useEffect, useState } from "react";
import {useLocation} from 'react-router-dom';

function useCurrentTab(config = {}) {
    const location = useLocation();
    const [tab, setTab] = useState(null);

    useEffect(() => {
        switch(location.pathname) {
            case '/overview':
                setTab("Overview");
                break;
            case '/manage-stake':
                setTab("Manage Stake");
                break;

            case '/rewards':
                setTab("Rewards");
                break;

            default:
                setTab("");
                break;

        }
    }, [location]);

    return { tab}
}

export default useCurrentTab;
